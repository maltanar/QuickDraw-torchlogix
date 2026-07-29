#!/bin/bash
# Build libsim_worker.so — C++ simulation harness for QuickDraw FPGA Simulator
#
# This script:
#   1. Runs Verilator to generate C++ model files from the HDL
#   2. Compiles sim_worker.cpp + Verilator model into a shared library
#
# Prerequisites: verilator, g++
# Run from the sim/ directory (or anywhere — script is self-relocating).

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HDL_DIR="$SCRIPT_DIR/.."          # fpga-imgpreproc/ (original RTL)
BUILD_DIR="$SCRIPT_DIR/build_worker"
OUT_LIB="$SCRIPT_DIR/libsim_worker.so"

echo "QuickDraw C++ Simulation Worker Build"
echo "======================================"
echo "  sim dir : $SCRIPT_DIR"
echo "  hdl dir : $HDL_DIR"
echo "  build   : $BUILD_DIR"
echo ""

# ---- Check dependencies -----------------------------------------------
if ! command -v verilator &>/dev/null; then
    echo "ERROR: verilator not found. Install with: sudo apt-get install verilator"
    exit 1
fi
if ! command -v g++ &>/dev/null; then
    echo "ERROR: g++ not found. Install with: sudo apt-get install build-essential"
    exit 1
fi

VERILATOR_ROOT=$(verilator --getenv VERILATOR_ROOT 2>/dev/null || true)
if [ -z "$VERILATOR_ROOT" ]; then
    for d in /usr/share/verilator /usr/local/share/verilator; do
        [ -d "$d/include" ] && { VERILATOR_ROOT="$d"; break; }
    done
fi
if [ -z "$VERILATOR_ROOT" ]; then
    echo "ERROR: Cannot locate Verilator include directory."
    exit 1
fi
INCLUDE_DIR="$VERILATOR_ROOT/include"
echo "Verilator root: $VERILATOR_ROOT"

# ---- Step 1: Verilate (generate C++ model) ----------------------------
mkdir -p "$BUILD_DIR"
echo ""
echo "[1/2] Running Verilator..."

verilator --cc --trace \
    --Mdir "$BUILD_DIR" \
    --top-module sim_top \
    -y "$SCRIPT_DIR" \
    -y "$HDL_DIR" \
    -DBOARD_FREQ=25000000 \
    -DBOARD_FREQ_STR='"25000000"' \
    -Wno-UNOPTFLAT \
    -Wno-WIDTH \
    -Wno-MULTIDRIVEN \
    -Wno-UNUSED \
    -Wno-BLKANDNBLK \
    -Wno-TIMESCALEMOD \
    -Wno-PINMISSING \
    -Wno-CASEINCOMPLETE \
    "$SCRIPT_DIR/sim_top.v" \
    "$HDL_DIR/uart.v"

echo "  Verilator done."

# ---- Step 2: Compile shared library ------------------------------------
echo ""
echo "[2/2] Compiling shared library..."

V_SRCS=$(find "$BUILD_DIR" -maxdepth 1 -name "V*.cpp" | sort | tr '\n' ' ')
if [ -z "$V_SRCS" ]; then
    echo "ERROR: No V*.cpp files found in $BUILD_DIR after Verilating."
    exit 1
fi

# verilated_vcd_c.cpp and verilated_threads.cpp may not exist in all installs
VCD_SRC=""
THREADS_SRC=""
[ -f "$INCLUDE_DIR/verilated_vcd_c.cpp"  ] && VCD_SRC="$INCLUDE_DIR/verilated_vcd_c.cpp"
[ -f "$INCLUDE_DIR/verilated_threads.cpp" ] && THREADS_SRC="$INCLUDE_DIR/verilated_threads.cpp"

g++ -O3 -shared -fPIC -std=c++14 \
    -I "$INCLUDE_DIR" \
    -I "$INCLUDE_DIR/vltstd" \
    -I "$BUILD_DIR" \
    -DVM_TRACE \
    "$SCRIPT_DIR/sim_worker.cpp" \
    $V_SRCS \
    "$INCLUDE_DIR/verilated.cpp" \
    $VCD_SRC \
    $THREADS_SRC \
    -o "$OUT_LIB"

echo ""
echo "✓ Built: $OUT_LIB"
echo ""
echo "The C++ backend is now available. Start the GUI with:"
echo "  python3 $SCRIPT_DIR/quickdraw_sim.py"
