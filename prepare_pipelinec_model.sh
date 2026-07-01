#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input-model.c> <output-model-pipelinec.c>" >&2
  exit 1
fi

IN_C="$1"
OUT_C="$2"

if [ ! -f "$IN_C" ]; then
  echo "Input model C not found: $IN_C" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUT_C")"

# Convert TorchLogix C to PipelineC-friendlier syntax:
# - avoid stdbool/_Bool lowering by using uint1_t
# - map plain int to explicit int32_t
# - replace ++ with += 1
# - drop circuit_bench helper to avoid unsupported pointer arithmetic patterns
tmp_out="$(mktemp)"

perl -pe '
  s@#include <stdbool\.h>@#include "uintN_t.h"@g;
  s@#include <stdint\.h>@#include "intN_t.h"@g;
  s@\bbool\b@uint1_t@g;
  s@\bint\b@int32_t@g;
  s@\btrue\b@((uint1_t)1)@g;
  s@\bfalse\b@((uint1_t)0)@g;
  s@\+\+@ += 1@g;
' "$IN_C" \
  | awk '/^void[[:space:]]+circuit_bench[[:space:]]*\(/ { exit } { print }' \
  > "$tmp_out"

mv "$tmp_out" "$OUT_C"

echo "Wrote PipelineC-converted model: $OUT_C"
