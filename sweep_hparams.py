#!/usr/bin/env python3
import argparse
import csv
import json
import subprocess
import sys
from datetime import datetime
from pathlib import Path
from io import StringIO
from typing import Dict, List, Optional


def build_runs() -> List[Dict]:
    runs = []
    run_id = 1
    for channel_scale in [1.0]:
        for weight_bit_width in [1, 2, 4, 8]:
            per_channel_options = [True] if weight_bit_width == 2 else [False]
            for per_channel in per_channel_options:
                for trial in range(1, 4):  # 3 trials
                    epochs = 50 if weight_bit_width in [1, 2] else 15
                    runs.append(
                        {
                            "run_id": run_id,
                            "channel_scale": channel_scale,
                            "weight_bit_width": weight_bit_width,
                            "activation_bit_width": 8,
                            "per_channel": per_channel,
                            "trial": trial,
                            "quant_input": True,
                            "export_qonnx": weight_bit_width == 1,
                            "export_qcdq": weight_bit_width != 1,
                            "ngpu": 0,
                            "epochs": epochs,
                            "no_narrow_range": True,
                        }
                    )
                    run_id += 1
    return runs


def to_int_flag(value: bool) -> int:
    return 1 if value else 0


def parse_training_log(log_file: Path) -> Dict[str, Optional[float]]:
    if not log_file.exists():
        return {
            "best_test_accuracy": None,
            "final_test_accuracy": None,
            "final_test_loss": None,
        }

    best_test_accuracy = None
    final_test_accuracy = None
    final_test_loss = None

    with log_file.open("r", encoding="utf-8") as f:
        lines = [line.strip() for line in f if line.strip()]

    # First line is argument state; subsequent lines are per-epoch metrics.
    for line in lines[1:]:
        try:
            record = json.loads(line)
        except json.JSONDecodeError:
            continue

        if "test_accuracy" in record:
            acc = float(record["test_accuracy"])
            final_test_accuracy = acc
            if best_test_accuracy is None or acc > best_test_accuracy:
                best_test_accuracy = acc

        if "test_loss" in record:
            final_test_loss = float(record["test_loss"])

    return {
        "best_test_accuracy": best_test_accuracy,
        "final_test_accuracy": final_test_accuracy,
        "final_test_loss": final_test_loss,
    }


def find_training_log_file(log_dir: Path, config: Dict) -> Optional[Path]:
    """Find the training log file produced by main_qat.py for a run."""
    candidates = [
        log_dir / f"log_w{config['weight_bit_width']}a{config['activation_bit_width']}.txt",
        log_dir / f"log_{config['weight_bit_width']}bit.txt",
    ]

    for candidate in candidates:
        if candidate.exists():
            return candidate

    txt_logs = sorted(log_dir.glob("log*.txt"))
    if len(txt_logs) == 1:
        return txt_logs[0]
    if len(txt_logs) > 1:
        return txt_logs[-1]

    return None


def fmt_metric(value: Optional[float]) -> str:
    if value is None:
        return "NA"
    return f"{value:.6f}"


def make_csv_report(results: List[Dict]) -> str:
    headers = [
        "run_id",
        "channel_scale",
        "weight_bit_width",
        "activation_bit_width",
        "per_channel",
        "trial",
        "status",
        "best_test_accuracy",
        "final_test_accuracy",
        "final_test_loss",
        "notes",
    ]

    buf = StringIO()
    writer = csv.writer(buf)
    writer.writerow(headers)

    for r in results:
        writer.writerow([
            str(r["run_id"]),
            str(r["channel_scale"]),
            str(r["weight_bit_width"]),
            str(r["activation_bit_width"]),
            str(to_int_flag(r["per_channel"])),
            str(r["trial"]),
            r["status"],
            fmt_metric(r.get("best_test_accuracy")),
            fmt_metric(r.get("final_test_accuracy")),
            fmt_metric(r.get("final_test_loss")),
            r.get("notes", ""),
        ])

    return buf.getvalue()


def append_result_to_csv(report_path: Path, result: Dict, is_first: bool) -> None:
    """Append a single result row to the CSV file."""
    headers = [
        "run_id",
        "channel_scale",
        "weight_bit_width",
        "activation_bit_width",
        "per_channel",
        "trial",
        "status",
        "best_test_accuracy",
        "final_test_accuracy",
        "final_test_loss",
        "notes",
    ]

    buf = StringIO()
    writer = csv.writer(buf)

    if is_first:
        writer.writerow(headers)

    writer.writerow([
        str(result["run_id"]),
        str(result["channel_scale"]),
        str(result["weight_bit_width"]),
        str(result["activation_bit_width"]),
        str(to_int_flag(result["per_channel"])),
        str(result["trial"]),
        result["status"],
        fmt_metric(result.get("best_test_accuracy")),
        fmt_metric(result.get("final_test_accuracy")),
        fmt_metric(result.get("final_test_loss")),
        result.get("notes", ""),
    ])

    with report_path.open("a", encoding="utf-8") as f:
        f.write(buf.getvalue())


def run_one(config: Dict, output_root: Path, dry_run: bool) -> Dict:
    run_name = (
        f"run_{config['run_id']:02d}"
        f"_cs{config['channel_scale']}"
        f"_w{config['weight_bit_width']}a{config['activation_bit_width']}"
        f"_pc{to_int_flag(config['per_channel'])}"
        f"_trial{config['trial']}"
    )
    run_dir = output_root / run_name
    save_dir = run_dir / "checkpoints"
    log_dir = run_dir / "logs"
    run_dir.mkdir(parents=True, exist_ok=True)
    save_dir.mkdir(parents=True, exist_ok=True)
    log_dir.mkdir(parents=True, exist_ok=True)

    cmd = [
        sys.executable,
        "main_qat.py",
        "--channel_scale",
        str(config["channel_scale"]),
        "--weight_bit_width",
        str(config["weight_bit_width"]),
        "--act_bit_width",
        str(config["activation_bit_width"]),
        "--quant_input",
        "--ngpu",
        str(config["ngpu"]),
        "--epochs",
        str(config["epochs"]),
        "--no_narrow_range",
        "--save_dir",
        str(save_dir),
        "--log",
        str(log_dir),
    ]
    if config.get("export_qonnx"):
        cmd.append("--export_qonnx")
    if config.get("export_qcdq"):
        cmd.append("--export_qcdq")
    if config["per_channel"]:
        cmd.append("--per_channel")

    result = dict(config)

    if dry_run:
        result["status"] = "DRY_RUN"
        result["notes"] = "Command prepared only"
        result["best_test_accuracy"] = None
        result["final_test_accuracy"] = None
        result["final_test_loss"] = None
        result["command"] = " ".join(cmd)
        return result

    completed = subprocess.run(
        cmd,
        cwd=Path(__file__).resolve().parent,
        text=True,
        capture_output=True,
        check=False,
    )

    console_log = run_dir / "console.log"
    console_log.write_text(
        "=== COMMAND ===\n"
        + " ".join(cmd)
        + "\n\n=== STDOUT ===\n"
        + completed.stdout
        + "\n\n=== STDERR ===\n"
        + completed.stderr,
        encoding="utf-8",
    )

    log_file = find_training_log_file(log_dir, config)
    metrics = (
        parse_training_log(log_file)
        if log_file is not None
        else {
            "best_test_accuracy": None,
            "final_test_accuracy": None,
            "final_test_loss": None,
        }
    )
    result.update(metrics)
    if completed.returncode == 0:
        result["status"] = "OK"
        result["notes"] = ""
    else:
        result["status"] = "FAIL"
        tail = completed.stderr.strip().splitlines()
        result["notes"] = tail[-1] if tail else f"returncode={completed.returncode}"

    result["command"] = " ".join(cmd)
    return result


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Sweep selected QAT hyperparameters and report markdown results."
    )
    parser.add_argument(
        "--output_root",
        type=str,
        default=None,
        help="Directory for run outputs and markdown report. Default: sweep_results_<timestamp>",
    )
    parser.add_argument(
        "--dry_run",
        action="store_true",
        help="Only print commands and produce a dry-run report without executing training.",
    )
    args = parser.parse_args()

    base_dir = Path(__file__).resolve().parent
    output_root = (
        Path(args.output_root)
        if args.output_root
        else base_dir / f"sweep_results_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
    )
    output_root.mkdir(parents=True, exist_ok=True)

    runs = build_runs()
    results = []
    report_path = output_root / "results.csv"

    for idx, config in enumerate(runs):
        print(
            f"[run {config['run_id']:02d}/{len(runs)}] "
            f"channel_scale={config['channel_scale']} "
            f"weight_bits={config['weight_bit_width']} "
            f"activation_bits={config['activation_bit_width']} "
            f"per_channel={to_int_flag(config['per_channel'])} "
            f"trial={config['trial']}"
        )
        result = run_one(config, output_root=output_root, dry_run=args.dry_run)
        results.append(result)
        append_result_to_csv(report_path, result, is_first=(idx == 0))

    report_path = output_root / "results.csv"
    commands_path = output_root / "commands.txt"
    commands_path.write_text(
        "\n".join(r.get("command", "") for r in results) + "\n",
        encoding="utf-8",
    )

    print("\nSaved report:", report_path)
    print("Saved command list:", commands_path)
    if args.dry_run:
        print("Dry run mode enabled: no training jobs were executed.")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())