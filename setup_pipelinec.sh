#!/usr/bin/env bash

set -euo pipefail

PIPELINEC_DIR="${1:-third_party/PipelineC}"

if [ -d "$PIPELINEC_DIR/.git" ]; then
  echo "PipelineC repo already exists at: $PIPELINEC_DIR"
else
  mkdir -p "$(dirname "$PIPELINEC_DIR")"
  git clone https://github.com/JulianKemmerer/PipelineC.git "$PIPELINEC_DIR"
fi

PIPELINEC_BIN_DIR="$PIPELINEC_DIR/src"

if [ ! -x "$PIPELINEC_BIN_DIR/pipelinec" ]; then
  echo "Expected PipelineC executable at: $PIPELINEC_BIN_DIR/pipelinec" >&2
  echo "Clone completed, but pipelinec executable was not found or is not executable." >&2
  exit 1
fi

echo
echo "PipelineC is ready."
echo "Add it to PATH for this shell:"
echo "  export PATH=\"$PIPELINEC_BIN_DIR:\$PATH\""
echo
echo "Then test with:"
echo "  pipelinec ./examples/blink.c"
