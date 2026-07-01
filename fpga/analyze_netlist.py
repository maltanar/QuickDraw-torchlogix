#!/usr/bin/env python3
"""Analyze Yosys JSON netlists for basic structural metrics.

Examples:
  ./fpga/analyze_netlist.py fpga/build/quickdraw_top.json
  ./fpga/analyze_netlist.py fpga/build.baseline/quickdraw_top.json --module quickdraw_top
"""

from __future__ import annotations

import argparse
import json
from collections import defaultdict
from pathlib import Path
from statistics import mean, median
from typing import Any

import matplotlib.pyplot as plt

# Port-name hints used to ignore control sinks in data fanout reports.
CONTROL_PORT_HINTS = ("clk", "clock", "rst", "reset", "sr", "ce", "en", "g")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Analyze synthesized netlist JSON from Yosys")
    parser.add_argument("netlist", type=Path, help="Path to Yosys JSON netlist")
    parser.add_argument(
        "--module",
        default="quickdraw_top",
        help="Module to analyze inside JSON (default: quickdraw_top)",
    )
    parser.add_argument(
        "--top-types",
        type=int,
        default=10,
        help="Show top N cell types by instance count (default: 10)",
    )
    parser.add_argument(
        "--no-control-filter",
        action="store_true",
        help="Skip extra fanout summary that excludes clock/reset/enable-like sinks",
    )
    parser.add_argument(
        "--hist-bins",
        type=int,
        default=0,
        help="Show N-bin histograms for fanout/depth samples (default: 0, disabled)",
    )
    parser.add_argument(
        "--plot-dir",
        type=Path,
        default=Path("fpga/netlist_analysis_plots"),
        help="Directory to write histogram plot PNG files (used when --hist-bins > 0)",
    )
    parser.add_argument(
        "--top-paths",
        type=int,
        default=0,
        help="Print K deepest FF->FF combinational paths (default: 0, disabled)",
    )
    return parser.parse_args()


def is_ff_type(cell_type: str) -> bool:
    t = cell_type.upper()
    return (
        "DFF" in t
        or "ADFF" in t
        or "SDFF" in t
        or "FD" in t
        or t.startswith("$DFF")
        or t.startswith("$ADFF")
    )


def is_control_port(port_name: str) -> bool:
    p = port_name.lower()
    return any(h in p for h in CONTROL_PORT_HINTS)


def fmt_number(value: float) -> str:
    if isinstance(value, int):
        return str(value)
    return f"{value:.3f}"


def load_module(path: Path, module_name: str) -> dict[str, Any]:
    with path.open("r", encoding="utf-8") as f:
        data = json.load(f)

    modules = data.get("modules", {})
    if module_name not in modules:
        names = ", ".join(sorted(modules.keys()))
        raise SystemExit(
            f"ERROR: module '{module_name}' not found in {path}. Available modules: {names}"
        )

    return modules[module_name]


def summarize_fanout(
    bit_drivers: dict[int, list[tuple[str, str, int]]],
    sink_map: dict[int, list[tuple[str, str, int]]],
) -> tuple[float, float, int, list[int]]:
    values: list[int] = []
    for bit, drivers in bit_drivers.items():
        fo = len(sink_map.get(bit, []))
        for _ in drivers:
            values.append(fo)

    if not values:
        return 0.0, 0.0, 0, []

    return mean(values), float(median(values)), max(values), values


def make_histogram(values: list[int], bins: int) -> list[tuple[int, int, int]]:
    if bins <= 0 or not values:
        return []

    lo = min(values)
    hi = max(values)
    if lo == hi:
        return [(lo, hi, len(values))]

    # Integer-width buckets spanning [lo, hi].
    width = max(1, (hi - lo + bins) // bins)
    real_bins = ((hi - lo) // width) + 1
    counts = [0] * real_bins

    for v in values:
        idx = (v - lo) // width
        if idx >= real_bins:
            idx = real_bins - 1
        counts[idx] += 1

    ranges: list[tuple[int, int, int]] = []
    for i, c in enumerate(counts):
        b_lo = lo + i * width
        b_hi = min(hi, b_lo + width - 1)
        ranges.append((b_lo, b_hi, c))
    return ranges


def print_histogram(title: str, values: list[int], bins: int) -> None:
    hist = make_histogram(values, bins)
    if not hist:
        return

    print(title)
    for b_lo, b_hi, c in hist:
        label = f"[{b_lo},{b_hi}]" if b_lo != b_hi else f"[{b_lo}]"
        print(f"  {label:>14} : {c}")


def save_histogram_plot(
    values: list[int],
    bins: int,
    title: str,
    x_label: str,
    out_path: Path,
) -> None:
    hist = make_histogram(values, bins)
    if not hist:
        return

    labels = [f"{lo}-{hi}" if lo != hi else f"{lo}" for lo, hi, _ in hist]
    counts = [c for _, _, c in hist]

    fig_w = max(8.0, min(16.0, 0.75 * len(labels) + 2.0))
    fig, ax = plt.subplots(figsize=(fig_w, 4.8))
    x = list(range(len(labels)))
    ax.bar(x, counts, color="#3f8fd2", edgecolor="#2a5f8f")
    ax.set_title(title)
    ax.set_xlabel(x_label)
    ax.set_ylabel("Count")
    ax.set_xticks(x)
    ax.set_xticklabels(labels, rotation=45, ha="right")
    ax.grid(axis="y", alpha=0.25)
    fig.tight_layout()

    out_path.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(out_path, dpi=150)
    plt.close(fig)


def max_ff_to_ff_comb_depth(
    ff_cells: set[str],
    comb_cells: set[str],
    succ_all: dict[str, set[str]],
) -> tuple[int, list[int], list[tuple[int, str, str, list[str]]]]:
    succ_comb: dict[str, set[str]] = defaultdict(set)
    succ_to_ff: dict[str, set[str]] = defaultdict(set)

    for src, dsts in succ_all.items():
        for dst in dsts:
            if dst in ff_cells:
                succ_to_ff[src].add(dst)
            else:
                succ_comb[src].add(dst)

    state: dict[str, int] = {}
    memo: dict[str, tuple[float, str | None, list[str]]] = {}

    def best_from(node: str) -> tuple[float, str | None, list[str]]:
        st = state.get(node, 0)
        if st == 1:
            # Break combinational loops conservatively.
            return float("-inf"), None, []
        if st == 2:
            return memo[node]

        state[node] = 1
        best_depth = float("-inf")
        best_sink_ff: str | None = None
        best_path: list[str] = []

        # Direct comb-node to FF successor path: node -> dst_ff
        for dst_ff in succ_to_ff.get(node, ()): 
            if 1.0 > best_depth:
                best_depth = 1.0
                best_sink_ff = dst_ff
                best_path = [node, dst_ff]

        for nxt in succ_comb.get(node, ()):
            child_depth, child_sink_ff, child_path = best_from(nxt)
            if child_depth != float("-inf") and child_sink_ff is not None and child_path:
                cand_depth = 1.0 + child_depth
                if cand_depth > best_depth:
                    best_depth = cand_depth
                    best_sink_ff = child_sink_ff
                    best_path = [node] + child_path

        state[node] = 2
        memo[node] = (best_depth, best_sink_ff, best_path)
        return memo[node]

    max_depth = -1
    ff_depth_samples: list[int] = []
    ff_best_paths: list[tuple[int, str, str, list[str]]] = []

    for ff in ff_cells:
        best_for_ff = -1
        best_sink_ff_for_ff: str | None = None
        best_path_for_ff: list[str] = []

        for dst_ff in succ_to_ff.get(ff, ()):
            if 0 > best_for_ff:
                best_for_ff = 0
                best_sink_ff_for_ff = dst_ff
                best_path_for_ff = [ff, dst_ff]

        for nxt in succ_comb.get(ff, ()):
            child_depth, child_sink_ff, child_path = best_from(nxt)
            if child_depth != float("-inf") and child_sink_ff is not None and child_path:
                cand_depth = int(child_depth)
                if cand_depth > best_for_ff:
                    best_for_ff = cand_depth
                    best_sink_ff_for_ff = child_sink_ff
                    best_path_for_ff = [ff] + child_path

        if best_for_ff >= 0:
            ff_depth_samples.append(best_for_ff)
            max_depth = max(max_depth, best_for_ff)
            if best_sink_ff_for_ff is not None and best_path_for_ff:
                ff_best_paths.append((best_for_ff, ff, best_sink_ff_for_ff, best_path_for_ff))

    ff_best_paths.sort(key=lambda x: x[0], reverse=True)
    return max_depth, ff_depth_samples, ff_best_paths


def main() -> None:
    args = parse_args()

    if not args.netlist.is_file():
        raise SystemExit(f"ERROR: netlist file not found: {args.netlist}")
    if args.hist_bins < 0:
        raise SystemExit("ERROR: --hist-bins must be >= 0")
    if args.top_paths < 0:
        raise SystemExit("ERROR: --top-paths must be >= 0")

    mod = load_module(args.netlist, args.module)
    cells: dict[str, dict[str, Any]] = mod.get("cells", {})

    cell_types = {name: cdef.get("type", "") for name, cdef in cells.items()}
    ff_cells = {name for name, ctype in cell_types.items() if is_ff_type(ctype)}
    comb_cells = set(cells.keys()) - ff_cells

    bit_drivers: dict[int, list[tuple[str, str, int]]] = defaultdict(list)
    bit_sinks_all: dict[int, list[tuple[str, str, int]]] = defaultdict(list)
    bit_sinks_data: dict[int, list[tuple[str, str, int]]] = defaultdict(list)

    for cname, cdef in cells.items():
        pdirs = cdef.get("port_directions", {})
        conns = cdef.get("connections", {})

        for port, bits in conns.items():
            direction = pdirs.get(port)
            if direction not in {"input", "output"}:
                continue

            for idx, bit in enumerate(bits):
                if isinstance(bit, str):
                    # constants ('0'/'1') and x do not form graph edges
                    continue

                if direction == "output":
                    bit_drivers[bit].append((cname, port, idx))
                else:
                    bit_sinks_all[bit].append((cname, port, idx))
                    if not is_control_port(port):
                        bit_sinks_data[bit].append((cname, port, idx))

    succ_all: dict[str, set[str]] = defaultdict(set)
    for bit, drivers in bit_drivers.items():
        sinks = bit_sinks_all.get(bit, [])
        for dcell, _, _ in drivers:
            for scall, _, _ in sinks:
                if dcell != scall:
                    succ_all[dcell].add(scall)

    avg_fo_all, med_fo_all, max_fo_all, fanout_samples_all = summarize_fanout(bit_drivers, bit_sinks_all)
    avg_fo_data, med_fo_data, max_fo_data, fanout_samples_data = summarize_fanout(bit_drivers, bit_sinks_data)
    max_depth, depth_samples, ff_best_paths = max_ff_to_ff_comb_depth(ff_cells, comb_cells, succ_all)

    type_counts: dict[str, int] = defaultdict(int)
    for ctype in cell_types.values():
        type_counts[ctype] += 1

    print(f"Netlist: {args.netlist}")
    print(f"Module : {args.module}")
    print(f"Total cells         : {len(cells)}")
    print(f"FF-like cells       : {len(ff_cells)}")
    print(f"Combinational cells : {len(comb_cells)}")
    print("")
    print("Fanout (output bits -> driven input bits):")
    print(f"  All sinks            avg={fmt_number(avg_fo_all)} med={fmt_number(med_fo_all)} max={max_fo_all}")
    if not args.no_control_filter:
        print(
            f"  Data-only sinks      avg={fmt_number(avg_fo_data)} med={fmt_number(med_fo_data)} max={max_fo_data}"
        )
    print("")
    print("Estimated max FF->FF combinational depth (cell-count):")
    print(f"  {max_depth}")

    if args.top_paths > 0:
        print("")
        print(f"Top {args.top_paths} deepest FF->FF combinational paths:")
        for i, (depth, src_ff, dst_ff, path_nodes) in enumerate(ff_best_paths[: args.top_paths], start=1):
            print(f"  {i}. depth={depth} src={src_ff} dst={dst_ff}")
            print(f"     path: {' -> '.join(path_nodes)}")

    if args.hist_bins > 0:
        print_histogram("FF->FF depth histogram (per source FF):", depth_samples, args.hist_bins)
    print("")

    if args.hist_bins > 0:
        print_histogram("Fanout histogram (all sinks):", fanout_samples_all, args.hist_bins)
        if not args.no_control_filter:
            print_histogram("Fanout histogram (data-only sinks):", fanout_samples_data, args.hist_bins)
        print("")

        stem = f"{args.netlist.stem}_{args.module}"
        out_dir = args.plot_dir
        save_histogram_plot(
            depth_samples,
            args.hist_bins,
            "FF->FF Combinational Depth Histogram",
            "Depth bin (cell-count)",
            out_dir / f"{stem}_depth_hist.png",
        )
        save_histogram_plot(
            fanout_samples_all,
            args.hist_bins,
            "Fanout Histogram (All sinks)",
            "Fanout bin",
            out_dir / f"{stem}_fanout_all_hist.png",
        )
        if not args.no_control_filter:
            save_histogram_plot(
                fanout_samples_data,
                args.hist_bins,
                "Fanout Histogram (Data-only sinks)",
                "Fanout bin",
                out_dir / f"{stem}_fanout_data_hist.png",
            )

        print(f"Saved histogram plots to: {out_dir}")
        print(f"  - {out_dir / f'{stem}_depth_hist.png'}")
        print(f"  - {out_dir / f'{stem}_fanout_all_hist.png'}")
        if not args.no_control_filter:
            print(f"  - {out_dir / f'{stem}_fanout_data_hist.png'}")
        print("")

    print(f"Top {args.top_types} cell types by instance count:")
    for ctype, count in sorted(type_counts.items(), key=lambda kv: kv[1], reverse=True)[: args.top_types]:
        print(f"  {ctype}: {count}")


if __name__ == "__main__":
    main()
