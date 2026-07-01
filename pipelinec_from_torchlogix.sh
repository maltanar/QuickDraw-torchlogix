#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <torchlogix-model.c> [pipelinec-args...]" >&2
  echo "Example: $0 Checkpoints/model_logic.c --comb" >&2
  exit 1
fi

INPUT_C="$1"
shift || true

if [ ! -f "$INPUT_C" ]; then
  echo "Input model C not found: $INPUT_C" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IN_DIR="$(cd "$(dirname "$INPUT_C")" && pwd)"
IN_BASE="$(basename "$INPUT_C")"
IN_STEM="${IN_BASE%.c}"

CONVERTED_C="$IN_DIR/${IN_STEM}_pipelinec.c"
WRAPPER_C="$IN_DIR/${IN_STEM}_pipelinec_wrapper.c"
CONVERTED_BASE="$(basename "$CONVERTED_C")"

"$SCRIPT_DIR/prepare_pipelinec_model.sh" "$INPUT_C" "$CONVERTED_C"

{
  echo '#include "uintN_t.h"'
  echo
  echo '// Include the PipelineC-converted TorchLogix model.'
  echo "#include \"$CONVERTED_BASE\""
  echo
  echo '#pragma MAIN_MHZ model_logic_main 100.0'
  echo 'float model_logic_main('

  for i in $(seq 0 783); do
    sep="," 
    if [ "$i" -eq 783 ]; then
      sep=""
    fi
    printf '    uint1_t in%s%s\n' "$i" "$sep"
  done

  echo ')'
  echo '{'
  echo '    uint1_t in_vec[784];'
  echo '    float out_vec[10];'
  echo

  for i in $(seq 0 783); do
    echo "    in_vec[$i] = in$i;"
  done

  echo
  echo '    circuit(in_vec, out_vec);'
  echo '    return out_vec[0];'
  echo '}'
} > "$WRAPPER_C"

echo "Wrote PipelineC wrapper: $WRAPPER_C"

if [ "$#" -eq 0 ]; then
  set -- --comb
fi

"$SCRIPT_DIR/pipelinec_codegen.sh" "$WRAPPER_C" "$@"
