#!/usr/bin/env python3
"""
Fast C++ simulation backend for QuickDraw FPGA Simulator.

Loads libsim_worker.so (compiled from sim_worker.cpp via build_worker.sh)
through ctypes.  Presents the same public interface as VerilatorSimulator
in sim_verilator.py, so quickdraw_gui.py can use either backend.

Usage in quickdraw_gui.py:
    try:
        from sim_ctypes import create_simulator   # fast C++ path
    except (ImportError, OSError):
        from sim_verilator import create_simulator  # Python fallback
"""

import ctypes
import subprocess
import sys
import numpy as np
from pathlib import Path
from typing import Optional, Dict

# Maximum possible pixels returned by sw_get_vga_frame() at 640x480.
_MAX_VGA_PIXELS = 640 * 480


class VerilatorSimulator:
    """C++ simulation backend — wraps libsim_worker.so via ctypes."""

    def __init__(self, hdl_path=None, enable_vcd_trace: bool = False,
                 vcd_file: str = None):
        if hdl_path is None:
            hdl_path = Path(__file__).parent
        self.hdl_path = Path(hdl_path)
        self.enable_vcd_trace = enable_vcd_trace
        self.vcd_file = vcd_file or "sim_trace.vcd"

        lib_path = self.hdl_path / "libsim_worker.so"
        if self._needs_rebuild(lib_path):
            self._build(lib_path)

        self._lib = ctypes.CDLL(str(lib_path))
        self._setup_api()

        vcd_bytes = (str(self.hdl_path / self.vcd_file).encode()
                     if enable_vcd_trace else None)
        self._handle = ctypes.c_void_p(
            self._lib.sw_create(int(enable_vcd_trace), vcd_bytes)
        )
        if not self._handle:
            raise RuntimeError("sw_create() returned null")

        # Pre-allocated VGA frame output buffers (reused on every call)
        self._vga_addrs  = (ctypes.c_uint32 * _MAX_VGA_PIXELS)()
        self._vga_rgb444 = (ctypes.c_uint32 * _MAX_VGA_PIXELS)()

        print("✓ C++ sim_worker backend ready")

    def _needs_rebuild(self, lib_path: Path) -> bool:
        """Return True when libsim_worker.so is missing or older than key sources."""
        if not lib_path.exists():
            return True

        lib_mtime = lib_path.stat().st_mtime
        watched = [
            self.hdl_path / "sim_worker.cpp",
            self.hdl_path / "sim_top.v",
            self.hdl_path / "sim_vga_output.v",
            self.hdl_path.parent / "uart.v",
            self.hdl_path.parent / "control_uart.v",
        ]
        for src in watched:
            if src.exists() and src.stat().st_mtime > lib_mtime:
                return True
        return False

    # ------------------------------------------------------------------ build

    def _build(self, lib_path: Path):
        """Run build_worker.sh to compile the shared library."""
        script = (self.hdl_path / "build_worker.sh").resolve()
        if not script.exists():
            raise FileNotFoundError(
                f"libsim_worker.so not found and build_worker.sh is missing.\n"
                f"Re-run: cd {self.hdl_path} && bash build_worker.sh"
            )
        print("Building C++ simulation library (one-time compilation) …")
        r = subprocess.run(["bash", str(script)], cwd=str(self.hdl_path.resolve()))
        if r.returncode != 0 or not lib_path.exists():
            raise RuntimeError(
                "build_worker.sh failed — check compiler/Verilator output above."
            )

    # ------------------------------------------------------------------ ctypes setup

    def _setup_api(self):
        L = self._lib

        L.sw_create.restype  = ctypes.c_void_p
        L.sw_create.argtypes = [ctypes.c_int, ctypes.c_char_p]

        L.sw_destroy.restype  = None
        L.sw_destroy.argtypes = [ctypes.c_void_p]

        L.sw_stop_trace.restype  = None
        L.sw_stop_trace.argtypes = [ctypes.c_void_p]

        L.sw_set_camera_frame.restype  = None
        L.sw_set_camera_frame.argtypes = [
            ctypes.c_void_p,
            ctypes.POINTER(ctypes.c_uint8),
            ctypes.c_int, ctypes.c_int,
        ]

        L.sw_send_uart_bytes.restype  = None
        L.sw_send_uart_bytes.argtypes = [
            ctypes.c_void_p,
            ctypes.POINTER(ctypes.c_uint8),
            ctypes.c_int,
        ]

        L.sw_step.restype  = ctypes.c_int
        L.sw_step.argtypes = [ctypes.c_void_p, ctypes.c_int]

        L.sw_get_vga_frame.restype  = ctypes.c_int
        L.sw_get_vga_frame.argtypes = [
            ctypes.c_void_p,
            ctypes.POINTER(ctypes.c_uint32),
            ctypes.POINTER(ctypes.c_uint32),
        ]

        L.sw_recv_uart.restype  = ctypes.c_int
        L.sw_recv_uart.argtypes = [
            ctypes.c_void_p,
            ctypes.POINTER(ctypes.c_uint8),
            ctypes.c_int,
        ]

        for name, rtype in [
            ("sw_get_cycle",               ctypes.c_longlong),
            ("sw_get_cam_state",           ctypes.c_int),
            ("sw_get_cam_state_name",      ctypes.c_char_p),
            ("sw_get_cam_y",               ctypes.c_int),
            ("sw_get_cam_height",          ctypes.c_int),
            ("sw_get_cam_x",               ctypes.c_int),
            ("sw_get_cam_width",           ctypes.c_int),
            ("sw_get_cam_frames_sent",     ctypes.c_int),
            ("sw_get_vga_frames_received", ctypes.c_int),
            ("sw_get_vga_current_pixels",  ctypes.c_int),
        ]:
            getattr(L, name).restype  = rtype
            getattr(L, name).argtypes = [ctypes.c_void_p]

    # ------------------------------------------------------------------ public properties
    # These mirror the attribute names used by quickdraw_gui.py's SimulatorWorker.

    @property
    def cycle(self) -> int:
        return int(self._lib.sw_get_cycle(self._handle))

    @property
    def _cam_state(self) -> str:
        return self._lib.sw_get_cam_state_name(self._handle).decode()

    @property
    def _cam_y(self) -> int:
        return self._lib.sw_get_cam_y(self._handle)

    @property
    def _cam_height(self) -> int:
        return self._lib.sw_get_cam_height(self._handle)

    @property
    def _cam_x(self) -> int:
        return self._lib.sw_get_cam_x(self._handle)

    @property
    def _cam_width(self) -> int:
        return self._lib.sw_get_cam_width(self._handle)

    @property
    def _cam_frames_sent(self) -> int:
        return self._lib.sw_get_cam_frames_sent(self._handle)

    @property
    def _vga_frames_received(self) -> int:
        return self._lib.sw_get_vga_frames_received(self._handle)

    @property
    def _vga_current_frame(self):
        """Returns an object with __len__ for the status counter."""
        n = self._lib.sw_get_vga_current_pixels(self._handle)
        class _Proxy:
            def __len__(self): return n
        return _Proxy()

    # ------------------------------------------------------------------ public methods

    def submit_camera_frame(self, frame_array: np.ndarray):
        arr = np.ascontiguousarray(frame_array, dtype=np.uint8)
        h, w = arr.shape[:2]
        self._lib.sw_set_camera_frame(
            self._handle,
            arr.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            h, w,
        )

    def send_uart_command(self, cmd: str):
        data = cmd.encode("latin-1")
        buf  = (ctypes.c_uint8 * len(data)).from_buffer_copy(data)
        self._lib.sw_send_uart_bytes(self._handle, buf, len(data))

    def step(self, num_cycles: int = 1000):
        self._lib.sw_step(self._handle, num_cycles)

    def get_vga_output(self) -> Optional[Dict[int, int]]:
        n = self._lib.sw_get_vga_frame(
            self._handle, self._vga_addrs, self._vga_rgb444
        )
        if n < 0:
            return None
        return {int(self._vga_addrs[i]): int(self._vga_rgb444[i])
                for i in range(n)}

    def get_uart_output(self) -> Optional[str]:
        buf = (ctypes.c_uint8 * 4096)()
        n   = self._lib.sw_recv_uart(self._handle, buf, 4096)
        if n <= 0:
            return None
        result = ""
        for i in range(n):
            v = int(buf[i])
            result += chr(v) if 32 <= v < 127 else f"\\x{v:02x}"
        return result

    def stop(self):
        if self._handle:
            self._lib.sw_stop_trace(self._handle)

    def __del__(self):
        if hasattr(self, "_handle") and self._handle:
            self._lib.sw_destroy(self._handle)
            self._handle = None


def create_simulator(hdl_path=None, enable_vcd_trace=False,
                     vcd_file="sim_trace.vcd"):
    return VerilatorSimulator(
        hdl_path,
        enable_vcd_trace=enable_vcd_trace,
        vcd_file=vcd_file,
    )


if __name__ == "__main__":
    print("C++ simulation backend — use from quickdraw_gui.py or quickdraw_sim.py")
