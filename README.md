# QuickDraw Logic Neural Networks on GateMate

This repository contains the training, Verilog export, and FPGA integration for a live Quick, Draw! sketch-recognition demo on the Olimex GateMate-A1 board. It uses [TorchLogix](https://github.com/maltanar/torchlogix) to train fan-in-constrained, quantized logic neural networks whose neurons map to FPGA LUTs and export as compact, feedforward RTL.

The FPGA design accepts an OV7670 camera stream, thresholds it, extracts and downsizes a configurable region of interest to 28x28 pixels, classifies the sketch, and renders the result over VGA. The full system architecture, design-space exploration, and implementation results are described in the [project blog post](https://emlogic.no/2026/08/logic-neural-networks-on-the-gatemate-a1/).

The repository provides the following workflows:

1. **Train and export LNNs:** Use `main_logic.py` to train new TorchLogix logic neural networks, then export them to Verilog with `--export_verilog`.
2. **Use generated LNN RTL:** [verilog](verilog) contains pre-generated Verilog implementations exported from trained LNNs.
3. **Run the stand-alone GateMate demo:** [fpga-imgpreproc](fpga-imgpreproc) implements the GateMate-A1 OV7670-to-VGA sketch-recognition system described in the blog post, including a small emulator in [fpga-imgpreproc/sim](fpga-imgpreproc/sim).
4. **Run the UART-connected LNN demo:** [fpga](fpga) implements an LNN connected over UART. Use it together with the PyQt GUI application in [PyQtDemo](PyQtDemo).

The Python training tools are installable as a standard Python project in a virtual environment.

## Quick Start (venv)

1. Create and activate a virtual environment.

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
```

2. Install the project in editable mode.

```bash
pip install -e .
```

## Available CLI Commands

Installing the project creates these commands:

1. `quickdraw-prepare-data`
2. `quickdraw-logic-train`
3. `quickdraw-logic-sweep`

## Typical Local Workflow

1. Prepare dataset:

```bash
quickdraw-prepare-data --download 1 --categories 10 -v 0.2
```

2. Run TorchLogix logic-NN training examples:

```bash
quickdraw-logic-train --dataset mnist --no-mnist_exact_example --batch_size 128 --test_bs 128 --optimizer adam --learning_rate 0.02 --weight_decay 0 --input_binarization none --ngpu 0 -e 10
```

Generate Verilog after training (exports best validation checkpoint by default):

```bash
quickdraw-logic-train --dataset mnist --no-mnist_exact_example --batch_size 128 --test_bs 128 --optimizer adam --learning_rate 0.02 --weight_decay 0 --input_binarization none --ngpu 0 -e 10 --export_verilog --verilog_path Checkpoints/model_logic.v
```

Generate Verilog from the final model state instead of best validation checkpoint:

```bash
quickdraw-logic-train --dataset mnist --no-mnist_exact_example --batch_size 128 --test_bs 128 --optimizer adam --learning_rate 0.02 --weight_decay 0 --input_binarization none --ngpu 0 -e 10 --export_verilog --no-verilog_from_best --verilog_path Checkpoints/model_logic_final.v
```

Resume from a saved checkpoint and then export Verilog:

```bash
quickdraw-logic-train --dataset mnist --load_checkpoint Checkpoints/model_logic.pytorch --ngpu 0 -e 5 --export_verilog --verilog_path Checkpoints/model_logic_resumed.v
```

Instantiate a dense-only logic topology by passing an empty conv stage list and keeping the dense widths large enough for torchlogix connection coverage:

```bash
quickdraw-logic-train --batch_size 128 --test_bs 128 --optimizer adam --learning_rate 0.02 --weight_decay 0 --dataset quickdraw --conv_channels "" --dense_dims 4000,4000 --input_binarization none --ngpu 0 -e 10
```

If you want to sweep dense-only candidates, include an empty entry in the conv grid:

```bash
quickdraw-logic-sweep --ngpu 0 --epochs 5 --conv_channels_grid "|16|16,48" --dense_dims_grid "4000,4000" --tree_depth_grid "2,3" --receptive_field_grid "3,5" --tau_grid "4.0,8.0"
```

7. Run topology exploration over multiple logic architectures:

```bash
quickdraw-logic-sweep --ngpu 0 --epochs 5 --conv_channels_grid "16|16,48|16,48,144" --dense_dims_grid "1000,1000|2000,2000|4000,4000" --tree_depth_grid "2,3" --receptive_field_grid "3,5" --tau_grid "4.0,8.0"
```

The sweep writes per-trial logs and a global summary in `logic_sweep_logs/logic_sweep_summary.json`.

## Dataset Notes

[Quick, Draw!](https://github.com/googlecreativelab/quickdraw-dataset) contains 50M drawings across 345 categories. This project typically samples up to 5000 examples per class for training data generation.

Useful data-prep options:

1. `--categories` / `-c`: one of `10`, `30`, `100`, `all`
2. `--download` / `-d`: `1` to download raw `.npy` files, `0` to reuse local files
3. `--show_random_imgs` / `-show`: preview random generated samples

### Files produced by quickdraw-prepare-data

Running the command below:

```bash
quickdraw-prepare-data --download 1 --categories 10 -v 0.2
```

produces or updates these artifacts:

1. Raw class files in [Data](Data)
	- One file per class, for example [Data/eye.npy](Data/eye.npy) and [Data/car.npy](Data/car.npy).

2. Training split in [Dataset/train.npz](Dataset/train.npz)
	- Keys: `data` and `target`.
	- `data` shape is `(N_train, 784)` where each row is a flattened 28x28 grayscale sketch.
	- `target` shape is `(N_train,)` with integer class ids.

3. Test split in [Dataset/test.npz](Dataset/test.npz)
	- Keys: `data` and `target`.
	- Same format as training split.

4. Class mapping metadata in [Dataset/class_names.txt](Dataset/class_names.txt)
	- One line per class with class name and sample count.
	- This file is used by the loader to recover the number of classes and label mapping context.

For your sample run (`10` classes, `5000` max samples per class, validation fold `0.2`):

1. Total sampled examples: `10 * 5000 = 50000`
2. Test examples: `50000 * 0.2 = 10000`
3. Train examples: `50000 - 10000 = 40000`

That matches the printed output:

1. `x_train size: (40000, 784)`
2. `x_test size: (10000, 784)`

Note: integer class ids are assigned in the order files are loaded during dataset generation, so [Dataset/class_names.txt](Dataset/class_names.txt) is the source of truth for id-to-class interpretation.

## References

1. [Train a model in tf.keras with Colab, and run it in the browser with TensorFlow.js](https://medium.com/tensorflow/train-on-google-colab-and-run-on-the-browser-a-case-study-8a45f9b1474e)
2. [tfjs-converter](https://github.com/tensorflow/tfjs-converter)
3. [pytorch2keras](https://github.com/nerox8664/pytorch2keras)
4. [Original QuickDraw-pytorch repository](https://github.com/XJay18/QuickDraw-pytorch)


