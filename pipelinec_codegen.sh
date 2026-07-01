#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <input-c-file> [pipelinec-args...]" >&2
  echo "Example: $0 Checkpoints/model_logic.c --comb" >&2
  exit 1
fi

INPUT_C="$1"
shift || true

if [ ! -f "$INPUT_C" ]; then
  echo "Input C file not found: $INPUT_C" >&2
  exit 1
fi

if command -v pipelinec >/dev/null 2>&1; then
  PIPELINEC_CMD="pipelinec"
elif [ -x "third_party/PipelineC/src/pipelinec" ]; then
  PIPELINEC_CMD="third_party/PipelineC/src/pipelinec"
else
  echo "PipelineC not found on PATH and not found at third_party/PipelineC/src/pipelinec" >&2
  echo "Run: bash setup_pipelinec.sh" >&2
  echo "Then: export PATH=\"$PWD/third_party/PipelineC/src:$PATH\"" >&2
  exit 1
fi

if [ "$#" -eq 0 ]; then
  set -- --comb
fi

echo "Running: $PIPELINEC_CMD $INPUT_C $*"
"$PIPELINEC_CMD" "$INPUT_C" "$@"
