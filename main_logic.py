import argparse
import copy
import json
import os

import torch
import torch.nn as nn
import torch.nn.functional as F
from tqdm import tqdm
from torchvision import datasets, transforms

from DataUtils.load_data import QD_Dataset
from Model.logic_nets import mnist_tutorial_logic_convnet, quickdraw_logic_convnet


def parse_int_list(csv_text):
    values = [v.strip() for v in csv_text.split(",") if v.strip()]
    if not values:
        raise ValueError("Expected at least one integer value.")
    return tuple(int(v) for v in values)


def build_parser():
    parser = argparse.ArgumentParser(
        description="TorchLogix training on Quick, Draw! or MNIST data.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    parser.add_argument(
        "--dataset",
        type=str,
        choices=["quickdraw", "mnist"],
        default="quickdraw",
        help="Dataset to use: 'quickdraw' or 'mnist' (for sanity checking against torchlogix examples).",
    )
    parser.add_argument(
        "--mnist_exact_example",
        action=argparse.BooleanOptionalAction,
        default=True,
        help="When dataset=mnist, use exact torchlogix tutorial model + training defaults.",
    )
    parser.add_argument("--data_root", "-root", type=str, default="Dataset")
    parser.add_argument("--image_size", "-size", type=int, default=28)

    # Training
    parser.add_argument("--epochs", "-e", type=int, default=10)
    parser.add_argument("--batch_size", "-b", type=int, default=256)
    parser.add_argument("--learning_rate", "-lr", type=float, default=0.02)
    parser.add_argument("--weight_decay", "-wd", type=float, default=1e-4)
    parser.add_argument("--ngpu", type=int, default=0, help="0 or less for CPU")
    parser.add_argument("--optimizer", type=str, default="adam", choices=["adam", "adamw"])

    # Logic architecture and layer params
    parser.add_argument(
        "--conv_channels",
        type=str,
        default="16",
        help="Comma-separated conv kernel counts per logic-conv stage.",
    )
    parser.add_argument(
        "--dense_dims",
        type=str,
        default="4000,4000",
        help="Comma-separated dense logic layer widths. Final width must be divisible by num classes.",
    )
    parser.add_argument("--tree_depth", type=int, default=2)
    parser.add_argument("--receptive_field_size", type=int, default=3)
    parser.add_argument("--conv_stride", type=int, default=1)
    parser.add_argument("--conv_padding", type=int, default=0)
    parser.add_argument("--tau", type=float, default=8.0, help="GroupSum temperature")
    parser.add_argument("--lut_rank", type=int, default=2)
    parser.add_argument("--parametrization", type=str, default="raw")
    parser.add_argument("--connections", type=str, default="fixed")
    parser.add_argument(
        "--connections_init_method",
        type=str,
        default="",
        help="Optional init method passed to torchlogix connection kwargs (e.g. random-unique).",
    )
    parser.add_argument(
        "--channel_group_size",
        type=int,
        default=0,
        help="Optional channel group size for connection kwargs; <=0 disables.",
    )

    # Input binarization
    parser.add_argument(
        "--input_binarization",
        type=str,
        choices=["fixed", "dummy", "none"],
        default="fixed",
    )
    parser.add_argument("--input_threshold", type=float, default=0.0)

    # Testing
    parser.add_argument("--test_bs", "-tb", type=int, default=256)
    parser.add_argument(
        "--eval_relaxed",
        action="store_true",
        default=False,
        help="Also evaluate in relaxed mode (model.train()) for comparison.",
    )

    # Checkpoint / log
    parser.add_argument("--save_dir", "-s", type=str, default="./Checkpoints")
    parser.add_argument("--save_name", type=str, default="model_logic.pytorch")
    parser.add_argument("--log", type=str, default="./")
    parser.add_argument("--log_file", type=str, default="log_logic.txt")

    return parser


def _build_device(ngpu):
    if ngpu > 0 and torch.cuda.is_available():
        return torch.device("cuda")
    return torch.device("cpu")


def _epoch_pass(model, loader, image_size, device, optimizer=None, desc="Eval", force_train=False, is_mnist=False):
    is_training = optimizer is not None

    if is_training or force_train:
        model.train()
    else:
        model.eval()

    loss_avg = 0.0
    correct = 0
    total = 0

    data_loader = tqdm(loader, desc=desc)

    # TorchLogix uses train()/eval() to switch relaxed/discrete behavior.
    # During evaluation, explicitly disable gradients (matching torchlogix pattern)
    if is_training:
        grad_ctx = torch.enable_grad()
    else:
        grad_ctx = torch.no_grad()

    with grad_ctx:
        for data, target in data_loader:
            data = data.to(device)
            target = target.to(device)

            if is_mnist:
                # MNIST loader already provides (1, 28, 28) tensors in [0, 1] after ToTensor()
                # Already binarized by threshold in transform
                pass
            else:
                # Quick, Draw! data comes as flat (784,) arrays
                data = data.view(-1, 1, image_size, image_size)
                data = data / 255.0

            output = model(data)
            loss = F.cross_entropy(output, target)

            if is_training:
                optimizer.zero_grad()
                loss.backward()
                optimizer.step()

            pred = output.argmax(dim=1)
            correct += int((pred == target).sum().item())
            total += int(target.numel())
            loss_avg = loss_avg * 0.2 + float(loss.detach().cpu()) * 0.8


    accuracy = correct / max(total, 1)
    return loss_avg, accuracy


def run_training(args):
    if not os.path.isdir(args.log):
        os.makedirs(args.log)
    if not os.path.isdir(args.save_dir):
        os.makedirs(args.save_dir)

    log_path = os.path.join(args.log, args.log_file)
    state = {k: v for k, v in vars(args).items()}

    # Match torchlogix MNIST notebook defaults in sanity-check mode.
    if args.dataset == "mnist" and args.mnist_exact_example:
        batch_size = 128
        test_bs = 128
        opt_name = "adam"
        learning_rate = 0.02
        weight_decay = 0.0
    else:
        batch_size = args.batch_size
        test_bs = args.test_bs
        opt_name = args.optimizer
        learning_rate = args.learning_rate
        weight_decay = args.weight_decay

    state["effective_batch_size"] = batch_size
    state["effective_test_bs"] = test_bs
    state["effective_optimizer"] = opt_name
    state["effective_learning_rate"] = learning_rate
    state["effective_weight_decay"] = weight_decay

    with open(log_path, "w", encoding="utf-8") as log:
        log.write(json.dumps(state) + "\n")

        print("*" * 50)
        print(f"Loading the {args.dataset.upper()} data...")

        if args.dataset == "mnist":
            # MNIST: binarize pixels to {0, 1}
            # Use threshold 0.0 (any positive value becomes 1) following torchlogix convention
            transform_train = transforms.Compose(
                [
                    transforms.ToTensor(),
                    transforms.Lambda(lambda x: (x > 0.).float()),
                ]
            )
            transform_test = transforms.Compose(
                [
                    transforms.ToTensor(),
                    transforms.Lambda(lambda x: (x > 0.).float()),
                ]
            )
            train_data = datasets.MNIST(
                root=args.data_root,
                train=True,
                download=True,
                transform=transform_train,
            )
            test_data = datasets.MNIST(
                root=args.data_root,
                train=False,
                download=True,
                transform=transform_test,
            )
            num_classes = 10
            is_mnist = True
        else:
            # Quick, Draw!
            train_data = QD_Dataset(mtype="train", root=args.data_root)
            test_data = QD_Dataset(mtype="test", root=args.data_root)
            num_classes = train_data.get_number_classes()
            is_mnist = False

        train_loader = torch.utils.data.DataLoader(
            train_data, batch_size=batch_size, shuffle=True
        )
        test_loader = torch.utils.data.DataLoader(
            test_data, batch_size=test_bs, shuffle=False
        )

        print(f"Train images number: {len(train_data)}")
        print(f"Test images number: {len(test_data)}")

        conv_channels = parse_int_list(args.conv_channels)
        dense_dims = parse_int_list(args.dense_dims)

        connections_kwargs = {}
        if args.connections_init_method:
            connections_kwargs["init_method"] = args.connections_init_method
        if args.channel_group_size > 0:
            connections_kwargs["channel_group_size"] = args.channel_group_size

        if is_mnist and args.mnist_exact_example:
            model = mnist_tutorial_logic_convnet(tau=args.tau)
        else:
            effective_input_binarization = args.input_binarization
            # Match tutorial behavior on MNIST: input is already binarized in transforms,
            # so skip model-side binarization.
            if is_mnist:
                effective_input_binarization = "none"

            model = quickdraw_logic_convnet(
                num_classes=num_classes,
                image_size=args.image_size,
                conv_channels=conv_channels,
                dense_dims=dense_dims,
                tree_depth=args.tree_depth,
                receptive_field_size=args.receptive_field_size,
                conv_stride=args.conv_stride,
                conv_padding=args.conv_padding,
                tau=args.tau,
                input_binarization=effective_input_binarization,
                input_threshold=args.input_threshold,
                parametrization=args.parametrization,
                lut_rank=args.lut_rank,
                connections=args.connections,
                connections_kwargs=connections_kwargs,
            )

        device = _build_device(args.ngpu)
        model = model.to(device)

        if args.ngpu > 1 and torch.cuda.device_count() > 1:
            model = nn.DataParallel(model)

        print(model)

        if opt_name == "adamw":
            optimizer = torch.optim.AdamW(
                model.parameters(), lr=learning_rate, weight_decay=weight_decay
            )
        else:
            optimizer = torch.optim.Adam(
                model.parameters(), lr=learning_rate, weight_decay=weight_decay
            )

        best_accuracy = 0.0
        best_state = copy.deepcopy(model.state_dict())

        for epoch in range(args.epochs):
            print("")
            print("*" * 50)
            print(f"epoch {epoch + 1} is running...")

            # Explicitly set to train mode before training epoch (torchlogix pattern)
            model.train()

            train_loss, train_acc = _epoch_pass(
                model,
                train_loader,
                image_size=args.image_size,
                device=device,
                optimizer=optimizer,
                desc="Training logic model",
                is_mnist=is_mnist,
            )
            test_loss, test_acc = _epoch_pass(
                model,
                test_loader,
                image_size=args.image_size,
                device=device,
                optimizer=None,
                desc="Testing discrete model",
                is_mnist=is_mnist,
            )

            state["current_epoch"] = epoch + 1
            state["train_loss"] = train_loss
            state["train_accuracy"] = train_acc
            state["test_loss"] = test_loss
            state["test_accuracy"] = test_acc

            if args.eval_relaxed:
                relaxed_loss, relaxed_acc = _epoch_pass(
                    model,
                    test_loader,
                    image_size=args.image_size,
                    device=device,
                    optimizer=None,
                    desc="Testing relaxed model",
                    force_train=True,
                    is_mnist=is_mnist,
                )
                state["test_loss_relaxed"] = relaxed_loss
                state["test_accuracy_relaxed"] = relaxed_acc

            if test_acc > best_accuracy:
                best_accuracy = test_acc
                best_state = copy.deepcopy(model.state_dict())
                ckpt_path = os.path.join(args.save_dir, args.save_name)
                torch.save(best_state, ckpt_path)

            log.write(json.dumps(state) + "\n")
            log.flush()

            print(state)
            print(f"Best discrete accuracy: {best_accuracy:.4f}")
            print("*" * 50)

    return {
        "best_accuracy": float(best_accuracy),
        "checkpoint": os.path.join(args.save_dir, args.save_name),
        "conv_channels": args.conv_channels,
        "dense_dims": args.dense_dims,
        "tree_depth": args.tree_depth,
        "receptive_field_size": args.receptive_field_size,
        "tau": args.tau,
    }


def main():
    parser = build_parser()
    args = parser.parse_args()
    run_training(args)


if __name__ == "__main__":
    main()
