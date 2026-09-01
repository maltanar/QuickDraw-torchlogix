#!/bin/bash

# This script launches the project container.
# It assumes you have an AMD GPU and ROCm drivers installed.

docker run --rm -it \
  --device=/dev/kfd \
  --device=/dev/dri \
  --group-add video \
  -v "$(pwd):/workspace/quickdraw-torchlogix" \
  -w /workspace/quickdraw-torchlogix \
  quickdraw-torchlogix \
  bash
