#!/usr/bin/env bash
# build.sh – Synthesise, place-and-route, and optionally flash the
#            QuickDraw logic network for the GateMateA1-EVB.
#
# Toolchain required:
#   yosys          (with synth_gatemate plugin)
#   nextpnr-himbaechel  (with GateMate / CCGM1A1 support)
#   gmpack         (Cologne Chip bitstream packer, part of CC toolchain)
#   openFPGALoader (for flashing)
#
# Usage:
#   ./build.sh              – synthesis + P&R + pack bitstream
#   ./build.sh flash        – also flash to connected board
#   ./build.sh clean        – remove build artefacts
#
# Environment overrides (export before calling, or prefix on command line):
#   FREQ_MHZ=1              target clock frequency for P&R timing (MHz)
#   BAUD_RATE=115200        UART baud rate baked into the design
#   CLK_FREQ=10000000       FPGA clock frequency (Hz, must match oscillator)
#   BOARD=gatemate_evb_jtag openFPGALoader board name

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
FREQ_MHZ=${FREQ_MHZ:-1}           # P&R timing target (MHz) – conservative
BAUD_RATE=${BAUD_RATE:-115200}     # UART baud rate
CLK_FREQ=${CLK_FREQ:-10000000}     # Board oscillator (10 MHz on GateMateA1-EVB)
BOARD=${BOARD:-gatemate_evb_jtag}  # openFPGALoader -b argument

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
VERILOG_DIR="$PROJECT_ROOT/verilog"
BUILD_DIR="$SCRIPT_DIR/build"
LOG_DIR="$BUILD_DIR/logs"
TOP="quickdraw_top"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
die() { echo "ERROR: $*" >&2; exit 1; }

cmd_exists() { command -v "$1" &>/dev/null; }

check_tools() {
    local missing=()
    for t in yosys nextpnr-himbaechel gmpack; do
        cmd_exists "$t" || missing+=("$t")
    done
    if [[ ${#missing[@]} -gt 0 ]]; then
        die "Missing tools: ${missing[*]}"$'\n'"  Install the Cologne Chip GateMate toolchain from:"$'\n'"  https://colognechip.com/myfpga/gatemate-evaluation-kit/"
    fi
}

# ---------------------------------------------------------------------------
# Build steps
# ---------------------------------------------------------------------------
do_build() {
    check_tools

    mkdir -p "$BUILD_DIR" "$LOG_DIR"
    cd "$BUILD_DIR"

    echo "================================================================"
    echo " QuickDraw GateMate build"
    echo "   CLK_FREQ  = $CLK_FREQ Hz"
    echo "   BAUD_RATE = $BAUD_RATE bps"
    echo "   FREQ_MHZ  = $FREQ_MHZ MHz  (P&R timing target)"
    echo "================================================================"

    # ------------------------------------------------------------------
    # Step 1: Synthesis with yosys
    # ------------------------------------------------------------------
    echo ""
    echo "[1/3] Synthesis (yosys) ..."
    yosys -ql "$LOG_DIR/yosys.log" -p "
        read_verilog \
            $SCRIPT_DIR/uart.v \
            $SCRIPT_DIR/${TOP}.v \
            $VERILOG_DIR/mlp_quickdraw_4k_4k.v;
        chparam -set CLK_FREQ  $CLK_FREQ  ${TOP};
        chparam -set BAUD_RATE $BAUD_RATE ${TOP};
        synth_gatemate -top ${TOP} -luttree -nomx8 -nomult;
        write_json ${TOP}.json
    "
    echo "      Synthesis log: $LOG_DIR/yosys.log"

    # ------------------------------------------------------------------
    # Step 2: Place & Route with nextpnr-himbaechel
    # ------------------------------------------------------------------
    echo ""
    echo "[2/3] Place & Route (nextpnr-himbaechel) ..."
    nextpnr-himbaechel \
        --device CCGM1A1 \
        --json  "${TOP}.json" \
        -o fpga_mode=2 \
        -o "ccf=$SCRIPT_DIR/quickdraw.ccf" \
        -o "out=${TOP}.impl" \
        --freq  "$FREQ_MHZ" \
        --router router2 \
        -l "$LOG_DIR/pnr.log"
    echo "      P&R log: $LOG_DIR/pnr.log"

    # ------------------------------------------------------------------
    # Step 3: Pack bitstream
    # ------------------------------------------------------------------
    echo ""
    echo "[3/3] Packing bitstream (gmpack) ..."
    gmpack "${TOP}.impl" "${TOP}.bit"

    echo ""
    echo "================================================================"
    echo " Build complete."
    echo "   Bitstream : $BUILD_DIR/${TOP}.bit"
    echo "   Yosys log : $LOG_DIR/yosys.log"
    echo "   P&R log   : $LOG_DIR/pnr.log"
    echo "================================================================"
    echo ""
    echo "  To flash: $0 flash"
    echo "  Or:       openFPGALoader -b $BOARD $BUILD_DIR/${TOP}.bit"
}

do_flash() {
    local bitfile="$BUILD_DIR/${TOP}.bit"
    [[ -f "$bitfile" ]] || die "Bitfile not found: $bitfile  (run '$0' first)"
    cmd_exists openFPGALoader || die "openFPGALoader not found in PATH"
    echo "Flashing $bitfile to board '$BOARD' ..."
    echo "(You may need to run this with sudo if JTAG device is not accessible)"
    openFPGALoader -b "$BOARD" "$bitfile"
    echo "Flash complete."
}

do_clean() {
    echo "Cleaning build artefacts ..."
    rm -rf "$BUILD_DIR"
    echo "Done."
}

# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------
case "${1:-build}" in
    build)
        do_build
        ;;
    flash)
        do_flash
        ;;
    build_and_flash|all)
        do_build
        do_flash
        ;;
    clean)
        do_clean
        ;;
    *)
        echo "Usage: $0 [build | flash | build_and_flash | clean]"
        echo ""
        echo "Environment variables:"
        echo "  FREQ_MHZ=<n>      P&R timing target in MHz   (default: 1)"
        echo "  BAUD_RATE=<n>     UART baud rate             (default: 115200)"
        echo "  CLK_FREQ=<n>      Board oscillator in Hz     (default: 10000000)"
        echo "  BOARD=<name>      openFPGALoader board name  (default: gatemate_evb_jtag)"
        exit 1
        ;;
esac
