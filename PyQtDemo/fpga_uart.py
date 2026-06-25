"""
fpga_uart.py – PC-side UART bridge for QuickDraw FPGA inference.

Protocol (8N1, default 115200 baud):
  PC → FPGA : 98 bytes  = 784-bit binarised image (inp[783:0]), LSB first
  FPGA → PC : 40 bytes  = 320-bit scores (scores_flat[319:0]), LSB first
                           i.e. 10 × 32-bit signed integers

Requires: pyserial  (pip install pyserial)
"""

import serial


class FPGAUARTInference:
    """Send an input bitmap to the FPGA and return the raw scores integer."""

    # Number of bytes in each direction
    _TX_BYTES = 98   # 784 bits / 8
    _RX_BYTES = 40   # 320 bits / 8

    def __init__(self, port: str = "/dev/ttyACM0", baud: int = 115200,
                 timeout: float = 5.0):
        self.port = port
        self.baud = baud
        self.timeout = timeout
        self._ser: serial.Serial | None = None
        self.last_tx_bytes: bytes = b""
        self.last_rx_bytes: bytes = b""

    # ------------------------------------------------------------------
    # Connection management
    # ------------------------------------------------------------------

    def open(self) -> None:
        """Open the serial port. Raises serial.SerialException on failure."""
        if self._ser is not None and self._ser.is_open:
            return
        self._ser = serial.Serial(
            port=self.port,
            baudrate=self.baud,
            bytesize=serial.EIGHTBITS,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            timeout=self.timeout,
        )
        # Discard any stale bytes left in the FPGA's TX buffer
        self._ser.reset_input_buffer()

    def close(self) -> None:
        """Close the serial port if open."""
        if self._ser is not None:
            try:
                self._ser.close()
            except Exception:
                pass
            self._ser = None

    def is_open(self) -> bool:
        return self._ser is not None and self._ser.is_open

    # ------------------------------------------------------------------
    # Inference
    # ------------------------------------------------------------------

    def run_inference(self, inp_value: int) -> int:
        """
        Run one inference pass on the FPGA.

        Parameters
        ----------
        inp_value : int
            784-bit integer representing the binarised image (inp[783:0]).
            Bit 0 corresponds to pixel 0, etc.

        Returns
        -------
        int
            320-bit integer (scores_flat[319:0]).
            Use unpack_scores() from sketch_demo to extract per-class logits.

        Raises
        ------
        IOError
            If fewer than 40 response bytes arrive within the timeout.
        RuntimeError
            If the serial port is not open.
        """
        if not self.is_open():
            raise RuntimeError("Serial port is not open; call open() first")

        payload = inp_value.to_bytes(self._TX_BYTES, byteorder="little")
        self.last_tx_bytes = payload

        # Flush stale input before sending so we don't misinterpret old data
        self._ser.reset_input_buffer()
        self._ser.write(payload)

        response = self._ser.read(self._RX_BYTES)
        self.last_rx_bytes = response
        if len(response) < self._RX_BYTES:
            raise IOError(
                f"UART timeout: expected {self._RX_BYTES} bytes from FPGA, "
                f"got {len(response)}.  "
                "Check that the bitfile is loaded and the baud rate matches."
            )

        return int.from_bytes(response, byteorder="little")

    # ------------------------------------------------------------------
    # Context-manager support
    # ------------------------------------------------------------------

    def __enter__(self):
        self.open()
        return self

    def __exit__(self, *_):
        self.close()
