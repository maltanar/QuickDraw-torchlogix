import argparse
import copy
import itertools
import json
import os

from main_logic import build_parser as build_logic_train_parser
from main_logic import run_training


def parse_grid(spec, cast=str):
    return [cast(x.strip()) for x in spec.split(",") if x.strip()]


def parse_topology_grid(spec):
    # Example: "16|16,48|16,48,144"
    options = [x.strip() for x in spec.split("|")]
    if not options:
        raise ValueError("Topology grid cannot be empty.")
    return options


def build_parser():
    parser = argparse.ArgumentParser(
        description="Topology exploration for torchlogix Quick, Draw! models.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    parser.add_argument("--data_root", type=str, default="Dataset")
    parser.add_argument("--image_size", type=int, default=28)

    # Shared train hyperparams
    parser.add_argument("--epochs", type=int, default=5)
    parser.add_argument("--batch_size", type=int, default=256)
    parser.add_argument("--test_bs", type=int, default=256)
    parser.add_argument("--learning_rate", type=float, default=0.02)
    parser.add_argument("--weight_decay", type=float, default=1e-4)
    parser.add_argument("--optimizer", type=str, default="adam", choices=["adam", "adamw"])
    parser.add_argument("--ngpu", type=int, default=0)

    # Logic options shared across trials
    parser.add_argument("--lut_rank", type=int, default=2)
    parser.add_argument("--parametrization", type=str, default="raw")
    parser.add_argument("--connections", type=str, default="fixed")
    parser.add_argument("--connections_init_method", type=str, default="")
    parser.add_argument("--channel_group_size", type=int, default=0)
    parser.add_argument("--input_binarization", type=str, default="fixed", choices=["fixed", "dummy"])
    parser.add_argument("--input_threshold", type=float, default=0.0)
    parser.add_argument("--conv_stride", type=int, default=1)
    parser.add_argument("--conv_padding", type=int, default=0)

    # Topology search space
    parser.add_argument(
        "--conv_channels_grid",
        type=str,
        default="16|16,48|16,48,144",
        help="'|' separates different topology candidates; within each candidate ',' separates layer widths.",
    )
    parser.add_argument(
        "--dense_dims_grid",
        type=str,
        default="1000,1000|2000,2000|4000,4000",
        help="'|' separates different dense-stack candidates.",
    )
    parser.add_argument("--tree_depth_grid", type=str, default="2,3")
    parser.add_argument("--receptive_field_grid", type=str, default="3,5")
    parser.add_argument("--tau_grid", type=str, default="4.0,8.0")

    # Output
    parser.add_argument("--save_dir", type=str, default="./Checkpoints/logic_sweep")
    parser.add_argument("--log", type=str, default="./logic_sweep_logs")
    parser.add_argument("--results_file", type=str, default="logic_sweep_results.jsonl")
    parser.add_argument("--max_trials", type=int, default=0, help="0 means run all candidates.")

    return parser


def main():
    args = build_parser().parse_args()

    conv_grid = parse_topology_grid(args.conv_channels_grid)
    dense_grid = parse_topology_grid(args.dense_dims_grid)
    tree_depth_grid = parse_grid(args.tree_depth_grid, cast=int)
    receptive_field_grid = parse_grid(args.receptive_field_grid, cast=int)
    tau_grid = parse_grid(args.tau_grid, cast=float)

    trial_grid = list(
        itertools.product(
            conv_grid,
            dense_grid,
            tree_depth_grid,
            receptive_field_grid,
            tau_grid,
        )
    )

    if args.max_trials > 0:
        trial_grid = trial_grid[: args.max_trials]

    if not os.path.isdir(args.save_dir):
        os.makedirs(args.save_dir)
    if not os.path.isdir(args.log):
        os.makedirs(args.log)

    results_path = os.path.join(args.log, args.results_file)
    summary = []

    base_train_args = build_logic_train_parser().parse_args([])

    with open(results_path, "w", encoding="utf-8") as result_log:
        for idx, (conv_channels, dense_dims, tree_depth, receptive_field_size, tau) in enumerate(
            trial_grid, start=1
        ):
            trial_name = f"trial_{idx:03d}"
            trial_save_dir = os.path.join(args.save_dir, trial_name)
            trial_log_dir = os.path.join(args.log, trial_name)

            trial_args = copy.deepcopy(base_train_args)
            trial_args.data_root = args.data_root
            trial_args.image_size = args.image_size
            trial_args.epochs = args.epochs
            trial_args.batch_size = args.batch_size
            trial_args.test_bs = args.test_bs
            trial_args.learning_rate = args.learning_rate
            trial_args.weight_decay = args.weight_decay
            trial_args.optimizer = args.optimizer
            trial_args.ngpu = args.ngpu

            trial_args.lut_rank = args.lut_rank
            trial_args.parametrization = args.parametrization
            trial_args.connections = args.connections
            trial_args.connections_init_method = args.connections_init_method
            trial_args.channel_group_size = args.channel_group_size
            trial_args.input_binarization = args.input_binarization
            trial_args.input_threshold = args.input_threshold
            trial_args.conv_stride = args.conv_stride
            trial_args.conv_padding = args.conv_padding

            trial_args.conv_channels = conv_channels
            trial_args.dense_dims = dense_dims
            trial_args.tree_depth = tree_depth
            trial_args.receptive_field_size = receptive_field_size
            trial_args.tau = tau
            trial_args.eval_relaxed = False

            trial_args.save_dir = trial_save_dir
            trial_args.save_name = "model_logic.pytorch"
            trial_args.log = trial_log_dir
            trial_args.log_file = "log_logic.txt"

            print("=" * 60)
            print(f"Running {trial_name}")
            print(
                "Topology:",
                {
                    "conv_channels": conv_channels,
                    "dense_dims": dense_dims,
                    "tree_depth": tree_depth,
                    "receptive_field_size": receptive_field_size,
                    "tau": tau,
                },
            )

            try:
                run_result = run_training(trial_args)
                trial_result = {
                    "trial": trial_name,
                    "status": "ok",
                    "best_accuracy": run_result["best_accuracy"],
                    "checkpoint": run_result["checkpoint"],
                    "conv_channels": conv_channels,
                    "dense_dims": dense_dims,
                    "tree_depth": tree_depth,
                    "receptive_field_size": receptive_field_size,
                    "tau": tau,
                }
            except Exception as exc:  # pylint: disable=broad-except
                trial_result = {
                    "trial": trial_name,
                    "status": "failed",
                    "error": str(exc),
                    "conv_channels": conv_channels,
                    "dense_dims": dense_dims,
                    "tree_depth": tree_depth,
                    "receptive_field_size": receptive_field_size,
                    "tau": tau,
                }

            summary.append(trial_result)
            result_log.write(json.dumps(trial_result) + "\n")
            result_log.flush()

    successful = [r for r in summary if r["status"] == "ok"]
    successful.sort(key=lambda x: x["best_accuracy"], reverse=True)

    summary_path = os.path.join(args.log, "logic_sweep_summary.json")
    with open(summary_path, "w", encoding="utf-8") as f:
        json.dump(
            {
                "total_trials": len(summary),
                "successful_trials": len(successful),
                "best_trial": successful[0] if successful else None,
                "all_trials": summary,
            },
            f,
            indent=2,
        )

    print("=" * 60)
    print(f"Finished {len(summary)} trials.")
    if successful:
        print(
            "Best trial:",
            successful[0]["trial"],
            "accuracy=",
            f"{successful[0]['best_accuracy']:.4f}",
        )
        print("Best checkpoint:", successful[0]["checkpoint"])
    else:
        print("No successful trial.")
    print("Summary written to:", summary_path)


if __name__ == "__main__":
    main()
