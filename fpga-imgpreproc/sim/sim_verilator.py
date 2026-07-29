#!/usr/bin/env python3
"""
Verilator-based FPGA simulation using PyVerilator
Compiles and interfaces with Verilator-generated models
"""

import os
import sys
import numpy as np
from pathlib import Path
from typing import Optional, Dict
from collections import deque

try:
    from pyverilator import PyVerilator
except ImportError:
    print("ERROR: pyverilator not installed. Install with: pip install pyverilator")
    sys.exit(1)


class VerilatorSimulator:
    """Verilator-based cycle-accurate FPGA simulation using PyVerilator"""
    
    def __init__(self, hdl_path: str = None, enable_vcd_trace: bool = False, vcd_file: str = None):
        """Initialize simulator
        
        Args:
            hdl_path: Path to fpga-imgpreproc directory
            enable_vcd_trace: Enable VCD waveform tracing
            vcd_file: Path to write VCD file (default: sim_trace.vcd)
        """
        if hdl_path is None:
            hdl_path = Path(__file__).parent
        else:
            hdl_path = Path(hdl_path)
        
        self.hdl_path = hdl_path
        self.cycle = 0
        self.enable_vcd_trace = enable_vcd_trace
        self.vcd_file = vcd_file or "sim_trace.vcd"
        self.tracer = None

        # UART RX input state machine (driving rx_i into the hardware)
        self._rx_byte_queue = deque()   # bytes waiting to be sent
        self._rx_state = 'idle'         # 'idle' | 'sending'
        self._rx_bits = []              # bit sequence for current byte
        self._rx_bit_idx = 0
        self._rx_countdown = 0

        # UART TX output state machine (decoding tx_o from the hardware)
        self._tx_state = 'idle'         # 'idle' | 'data' | 'stop'
        self._tx_bit_count = 0
        self._tx_bits = 0
        self._tx_sample_countdown = 0
        self._tx_decoded_queue = deque()  # decoded bytes ready to read

        # Camera input state machine (driving sim_cam_* into the hardware)
        self._cam_frame_queue = deque()  # frames waiting to be sent
        self._cam_frame = None
        self._cam_state = 'idle'        # 'idle'|'vsync_high'|'row_start'|'pixel'|'row_gap'|'frame_end'
        self._cam_height = 0
        self._cam_width = 0
        self._cam_y = 0
        self._cam_x = 0
        self._cam_byte = 0              # 0=first byte, 1=second byte of pixel
        self._cam_pclk = 0
        self._cam_countdown = 0

        # VGA output sampler
        self._vga_frame_queue = deque()  # completed frames ready to read
        self._vga_current_frame = {}    # addr -> rgb444 accumulator
        self._vga_last_vsync = 1        # previous vsync value for edge detect
        self._cam_frames_sent = 0       # completed camera frames injected
        self._vga_frames_received = 0   # completed VGA frames captured

        # Compile and initialize
        self._compile()
        self._initialize()
    
    def _compile(self):
        """Compile HDL with Verilator using PyVerilator"""
        print("Compiling HDL with Verilator via PyVerilator...")
        
        # PyVerilator needs the top-level verilog file and search paths
        top_file = str(self.hdl_path / "sim_top.v")
        
        if not Path(top_file).exists():
            raise FileNotFoundError(f"sim_top.v not found at {top_file}")
        
        # Build arguments for Verilator
        extra_args = [
            "-DBOARD_FREQ=25000000",
            "-DBOARD_FREQ_STR=\"25000000\"",
            "-Wno-UNOPTFLAT",
            "-Wno-WIDTH",
            "-Wno-MULTIDRIVEN",
            "-Wno-UNUSED",
            "-Wno-BLKANDNBLK",
            "-Wno-TIMESCALEMOD",
            "-Wno-PINMISSING",
            "-Wno-CASEINCOMPLETE",
        ]
        
        print(f"Top file: {top_file}")
        print(f"Search paths: {self.hdl_path}, {self.hdl_path.parent}\n")
        
        try:
            self.sim = PyVerilator.build(
                top_file,
                verilog_path=[str(self.hdl_path), str(self.hdl_path.parent)],
                build_dir=str(self.hdl_path / "build_sim_verilator"),
                top_module_name="sim_top",
                trace_depth=3 if self.enable_vcd_trace else 0,
                extra_args=extra_args
            )
            print("✓ Compilation successful\n")
            
            # Setup VCD tracing if enabled
            if self.enable_vcd_trace:
                vcd_path = self.hdl_path / self.vcd_file
                print(f"VCD tracing enabled to: {vcd_path}")
                try:
                    self.sim.start_vcd_trace(str(vcd_path))
                    print(f"✓ VCD tracer initialized")
                except Exception as e:
                    print(f"WARNING: Could not initialize tracer: {e}")
                    import traceback
                    traceback.print_exc()
        
        except Exception as e:
            print(f"PyVerilator compilation error: {e}")
            raise RuntimeError(f"Verilator compilation failed: {e}")
    
    def _initialize(self):
        """Initialize simulation"""
        print("Initializing simulation...")
        
        # Debug: check what signals are available
        print(f"Available signals: {[a for a in dir(self.sim.io) if not a.startswith('_')]}")
        
        # Try to initialize all input signals
        try:
            self.sim.io.clk = 0
            print("✓ clk signal available")
        except Exception as e:
            print(f"✗ clk signal: {e}")
        
        try:
            self.sim.io.rst_n = 1
            print("✓ rst_n signal available")
        except Exception as e:
            print(f"✗ rst_n signal: {e}")
        
        try:
            self.sim.io.rx_i = 1
            print("✓ rx_i signal available")
        except Exception as e:
            print(f"✗ rx_i signal: {e}")
        
        try:
            self.sim.io.sim_cam_data = 0
            print("✓ sim_cam_data signal available")
        except Exception as e:
            print(f"✗ sim_cam_data signal: {e}")
        
        # Perform power-on reset
        print("Performing reset sequence...")
        self.sim.io.sim_cam_vsync = 0
        self.sim.io.sim_cam_href = 0
        self.sim.io.sim_cam_pclk = 0
        self.sim.io.sim_cam_data = 0
        self.sim.io.rst_n = 0  # Assert reset (active low)
        for _ in range(5):
            self._clock_cycle()
        self.sim.io.rst_n = 1  # Release reset
        for _ in range(5):
            self._clock_cycle()
        
        print("✓ Simulation initialized\n")
    
    def submit_camera_frame(self, frame_array: np.ndarray):
        """Queue a camera frame for streaming; keep only the most recent one."""
        self._cam_frame_queue.clear()  # discard stale queued frames
        self._cam_frame_queue.append(frame_array.copy())

    def _drive_camera(self):
        """Camera input state machine — drives sim_cam_* one step per system clock"""
        if self._cam_state == 'idle':
            if self._cam_frame_queue:
                self._cam_frame = self._cam_frame_queue.popleft()
                frame_h, frame_w = self._cam_frame.shape[:2]
                # col_count (scanlines) maps to pix_x = canvas x-axis
                # row_count (pixels/scanline) maps to pix_y = canvas y-axis
                # So scanlines iterate canvas width, pixels iterate canvas height.
                self._cam_height = frame_w   # number of href pulses = canvas width
                self._cam_width  = frame_h   # pixels per scanline   = canvas height
                self._cam_y = 0
                self._cam_x = 0
                self._cam_byte = 0
                self._cam_pclk = 0
                self.sim.io.sim_cam_vsync = 1  # assert vsync=1 → WAIT_FRAME_START
                self.sim.io.sim_cam_href = 0
                self.sim.io.sim_cam_pclk = 0
                self._cam_state = 'vsync_high'
                self._cam_countdown = 10

        elif self._cam_state == 'vsync_high':
            self._cam_countdown -= 1
            if self._cam_countdown == 0:
                self.sim.io.sim_cam_vsync = 0  # deassert → ROW_CAPTURE
                self._cam_state = 'row_start'
                self._cam_countdown = 2

        elif self._cam_state == 'row_start':
            self._cam_countdown -= 1
            if self._cam_countdown == 0:
                self.sim.io.sim_cam_href = 1
                self._cam_x = 0
                self._cam_byte = 0
                self._cam_pclk = 0
                self.sim.io.sim_cam_pclk = 0
                self._cam_load_data()
                self._cam_state = 'pixel'

        elif self._cam_state == 'pixel':
            if self._cam_pclk == 0:
                self.sim.io.sim_cam_pclk = 1  # rising edge captures current byte
                self._cam_pclk = 1
            else:
                self.sim.io.sim_cam_pclk = 0
                self._cam_pclk = 0
                self._cam_byte += 1
                if self._cam_byte >= 2:
                    self._cam_byte = 0
                    self._cam_x += 1
                    if self._cam_x >= self._cam_width:
                        # End of row — deassert href and pulse pclk once so
                        # camera_read sees href=0 and increments col_count.
                        self.sim.io.sim_cam_href = 0
                        self._cam_y += 1
                        self._cam_state = 'row_end_pulse'
                    else:
                        self._cam_load_data()  # first byte of next pixel
                else:
                    self._cam_load_data()  # second byte of current pixel

        elif self._cam_state == 'row_end_pulse':
            # Fire one pclk cycle with href=0 so camera_read increments col_count.
            if self._cam_pclk == 0:
                self.sim.io.sim_cam_pclk = 1
                self._cam_pclk = 1
            else:
                self.sim.io.sim_cam_pclk = 0
                self._cam_pclk = 0
                if self._cam_y >= self._cam_height:
                    # All rows done — assert vsync=1, then pulse pclk so
                    # camera_read transitions back to WAIT_FRAME_START.
                    self.sim.io.sim_cam_vsync = 1
                    self._cam_state = 'frame_end_pulse'
                else:
                    self._cam_state = 'row_start'
                    self._cam_countdown = 2

        elif self._cam_state == 'frame_end_pulse':
            # Fire one pclk cycle with vsync=1 so camera_read goes back to
            # WAIT_FRAME_START for the next frame.
            if self._cam_pclk == 0:
                self.sim.io.sim_cam_pclk = 1
                self._cam_pclk = 1
            else:
                self.sim.io.sim_cam_pclk = 0
                self._cam_pclk = 0
                self.sim.io.sim_cam_vsync = 0
                self._cam_frames_sent += 1
                self._cam_state = 'idle'

    def _cam_load_data(self):
        """Set sim_cam_data for the current pixel byte.
        _cam_y = scanline index = canvas x;  _cam_x = pixel index = canvas y.
        """
        if (self._cam_frame is None
                or self._cam_x >= self._cam_frame.shape[0]  # canvas height
                or self._cam_y >= self._cam_frame.shape[1]):  # canvas width
            self.sim.io.sim_cam_data = 0
            return
        # Transposed access: row=_cam_x (canvas y), col=_cam_y (canvas x)
        r, g, b = self._cam_frame[self._cam_x, self._cam_y, :3]
        gray = (int(r) + int(g) + int(b)) // 3
        self.sim.io.sim_cam_data = gray & 0xFF

    def _sample_vga(self):
        """Sample VGA outputs every clock cycle; accumulate frames into queue"""
        try:
            if self.sim.io.sim_vga_in_display:
                addr = int(self.sim.io.sim_vga_pix_addr)
                r = int(self.sim.io.sim_vga_r)
                g = int(self.sim.io.sim_vga_g)
                b = int(self.sim.io.sim_vga_b)
                self._vga_current_frame[addr] = (r << 8) | (g << 4) | b

            vsync = int(self.sim.io.sim_vga_vsync)
            if vsync == 0 and self._vga_last_vsync == 1:  # falling edge = frame done
                if self._vga_current_frame:
                    self._vga_frame_queue.append(dict(self._vga_current_frame))
                    self._vga_frames_received += 1
                    self._vga_current_frame = {}
            self._vga_last_vsync = vsync
        except AttributeError:
            pass
    
    def _clock_cycle(self):
        """Execute one clock cycle and sample outputs"""
        # Advance camera and UART TX state machines before the clock edge
        self._drive_camera()
        self._drive_uart_rx()

        self.sim.io.clk = 0
        self.sim.eval()
        self.sim.io.clk = 1
        self.sim.eval()
        self.sim.io.clk = 0
        self.sim.eval()

        # Sample tx_o and VGA outputs after clock edge
        try:
            self._decode_uart_tx(self.sim.io.tx_o)
        except AttributeError:
            pass
        self._sample_vga()

        self.cycle += 1

    def _drive_uart_rx(self):
        """State machine: drive rx_i from the pending byte queue (one step per cycle)"""
        CYCLES_PER_BIT = 217

        if self._rx_state == 'idle':
            if self._rx_byte_queue:
                byte = self._rx_byte_queue.popleft()
                # Build: start(0), d0..d7 LSB-first, stop1(1), stop2(1)
                self._rx_bits = ([0] +
                                 [(byte >> i) & 1 for i in range(8)] +
                                 [1, 1])
                self._rx_bit_idx = 0
                self._rx_countdown = CYCLES_PER_BIT // 2
                self._rx_state = 'sending'
                self.sim.io.rx_i = self._rx_bits[0]  # assert start bit

        elif self._rx_state == 'sending':
            self._rx_countdown -= 1
            if self._rx_countdown == 0:
                self._rx_bit_idx += 1
                if self._rx_bit_idx >= len(self._rx_bits):
                    self._rx_state = 'idle'
                    self.sim.io.rx_i = 1  # line idle
                else:
                    self._rx_countdown = CYCLES_PER_BIT
                    self.sim.io.rx_i = self._rx_bits[self._rx_bit_idx]

    def _decode_uart_tx(self, tx_bit):
        """State machine: decode tx_o into bytes, one step per cycle"""
        CYCLES_PER_BIT = 217

        if self._tx_state == 'idle':
            if tx_bit == 0:  # start bit detected
                self._tx_state = 'data'
                self._tx_bit_count = 0
                self._tx_bits = 0
                # Sample first data bit at middle of bit period after start bit
                self._tx_sample_countdown = CYCLES_PER_BIT + CYCLES_PER_BIT // 2

        elif self._tx_state == 'data':
            self._tx_sample_countdown -= 1
            if self._tx_sample_countdown == 0:
                self._tx_bits |= (tx_bit & 1) << self._tx_bit_count
                self._tx_bit_count += 1
                if self._tx_bit_count >= 8:
                    self._tx_state = 'stop'
                    self._tx_sample_countdown = CYCLES_PER_BIT
                else:
                    self._tx_sample_countdown = CYCLES_PER_BIT

        elif self._tx_state == 'stop':
            self._tx_sample_countdown -= 1
            if self._tx_sample_countdown == 0:
                byte_val = self._tx_bits & 0xFF
                self._tx_decoded_queue.append(byte_val)
                print(f"UART TX decoded: {chr(byte_val)!r} (0x{byte_val:02x})")
                self._tx_state = 'idle'
    

    
    def send_uart_command(self, cmd: str):
        """Queue a UART command string for transmission during simulation steps"""
        print(f"UART queuing: {cmd!r}")
        for char in cmd:
            self._rx_byte_queue.append(ord(char))
    
    def get_vga_output(self) -> Optional[Dict[int, int]]:
        """Return the most recent completed VGA frame, or None if none available"""
        if not self._vga_frame_queue:
            return None
        # Discard stale frames, return only the latest
        frame = None
        while self._vga_frame_queue:
            frame = self._vga_frame_queue.popleft()
        return frame
    
    def get_uart_output(self) -> Optional[str]:
        """Drain all decoded UART TX bytes into a string"""
        if not self._tx_decoded_queue:
            return None
        result = ""
        while self._tx_decoded_queue:
            byte_val = self._tx_decoded_queue.popleft()
            result += chr(byte_val) if 32 <= byte_val < 127 else f"\\x{byte_val:02x}"
        return result
    
    def step(self, num_cycles: int = 1000):
        """Step simulation"""
        print(f"Stepping {num_cycles} cycles (total: {self.cycle})")
        
        for _ in range(num_cycles):
            self._clock_cycle()
    
    def stop(self):
        """Stop simulation and close VCD file"""
        if self.sim and self.enable_vcd_trace:
            try:
                self.sim.stop_vcd_trace()
                vcd_path = self.hdl_path / self.vcd_file
                print(f"\n✓ VCD trace written to {vcd_path}")
            except Exception as e:
                print(f"Error closing VCD tracer: {e}")


def create_simulator(hdl_path=None, enable_vcd_trace=False, vcd_file="sim_trace.vcd"):
    """Create Verilator simulator using PyVerilator
    
    Args:
        hdl_path: Path to HDL directory
        enable_vcd_trace: Enable VCD waveform tracing
        vcd_file: Path to write VCD file
    """
    return VerilatorSimulator(hdl_path, enable_vcd_trace=enable_vcd_trace, vcd_file=vcd_file)


if __name__ == "__main__":
    print("QuickDraw FPGA Simulator - Verilator via PyVerilator")
    print("Use from quickdraw_gui.py")
