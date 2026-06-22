# QuickDraw-brevitas

Train Quick, Draw! classifiers with PyTorch and run quantization-aware training (QAT) with Brevitas. The repo is installable as a standard Python project in a virtual environment.

## Quick Start (venv)

1. Create and activate a virtual environment.

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
```

2. Install the project with all dependencies in editable mode.

```bash
pip install -e ".[full]"
```

## Available CLI Commands

Installing the project creates these commands:

1. `quickdraw-prepare-data`
2. `quickdraw-train`
3. `quickdraw-qat-train`
4. `quickdraw-logic-train`
5. `quickdraw-logic-sweep`
6. `quickdraw-convert-qdq-to-qop`

## Typical Local Workflow

1. Prepare dataset:

```bash
quickdraw-prepare-data --download 1 --categories 10 -v 0.2
```

2. Run baseline (floating-point, should get ~95% accuracy) training for 5 epochs, and export to ONNX:

```bash
quickdraw-train --ngpu 0 -e 15 --export_onnx
```

3. Run QAT (8-bit quantization, should get ~95% accuracy) for 15 epochs, and export to QCDQ-formatted ONNX:

```bash
quickdraw-qat-train --ngpu 0 -e 15 --weight_bit_width 8 --act_bit_width 8 --quant_input --no_narrow_range  --export_qcdq
```

4. Convert QCDQ ONNX to QOperator ONNX:

```bash
quickdraw-convert-qdq-to-qop Checkpoints/model_8bit_qcdq.onnx Checkpoints/model_8bit_qop.onnx
```

5. (Optional) Generate C code (and executable stats) from an ONNX checkpoint:

```bash
bash codegen.sh model_w4a8_qop
```

`codegen.sh` takes the checkpoint **base name** under `Checkpoints/` (for example `model_w4a8_qop`), not a full `.onnx` filename.
6. Run TorchLogix logic-NN training (Quick, Draw! with a MNIST-style conv logic stack):

```bash
quickdraw-logic-train --ngpu 0 -e 10 --learning_rate 0.02 --conv_channels 16 --dense_dims 4000,4000 --tree_depth 2 --receptive_field_size 3 --tau 8.0 --input_binarization fixed
```

7. Run topology exploration over multiple logic architectures:

```bash
quickdraw-logic-sweep --ngpu 0 --epochs 5 --conv_channels_grid "16|16,48|16,48,144" --dense_dims_grid "1000,1000|2000,2000|4000,4000" --tree_depth_grid "2,3" --receptive_field_grid "3,5" --tau_grid "4.0,8.0"
```

The sweep writes per-trial logs and a global summary in `logic_sweep_logs/logic_sweep_summary.json`.

## Existing Script Workflow

After running `codegen.sh`:

1. Generated model source is available at `codegen/<model-name>/model.c`.
2. If `arm-zephyr-eabi-gcc` is available in `PATH`, a compiled executable is generated at `codegen/<model-name>/model` and deployment-oriented section stats are printed.

Example (`codegen.sh` output excerpt):

```text
=== Executable Deployment Stats: codegen/model_w4a8_qop/model ===
File size:                   542400 bytes (530KiB)
Code segment (.text*):       183216 bytes (179KiB)
Read-only vars (.rodata*):   331392 bytes (324KiB)
Writable init data (.data*): 4096 bytes (4.0KiB)
Zero-init data (.bss*):      1024 bytes (1.0KiB)
Static RAM (.data + .bss):   5120 bytes (5.0KiB)
Flash image estimate:        518704 bytes (507KiB)
```

If the ARM Zephyr toolchain is installed but not on `PATH`, add it before running:

```bash
export PATH="<zephyr-sdk>/arm-zephyr-eabi/bin:$PATH"
```

6. Run QAT (1-bit weights, 8-bit activations) for 50 eopchs and export to QONNX:

```bash
quickdraw-qat-train --ngpu 0 -e 50 --weight_bit_width 1 --act_bit_width 8 --quant_input  --export_qonnx --per_channel -lrs 5 -lrs 20
```

## Existing Script Workflow

The shell helpers still work:

```bash
bash run_experiments.sh
bash run_2bit_experiments.sh
```

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


