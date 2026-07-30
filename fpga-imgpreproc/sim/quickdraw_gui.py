#!/usr/bin/env python3
"""
PyQt6 GUI for FPGA Image Processing Simulation
Provides:
- Drawing canvas for camera input (640x480)
- VGA display output
- UART terminal for control commands
- Verilator-based hardware simulation
"""

import sys
import numpy as np
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, QGridLayout,
    QLabel, QPushButton, QSpinBox, QComboBox, QTextEdit, QLineEdit,
    QFrame, QSplitter, QCheckBox, QSlider
)
from PyQt6.QtGui import (
    QImage, QPixmap, QPainter, QPen, QBrush, QColor, QFont, QTextCursor
)
from PyQt6.QtCore import Qt, QTimer, QSize, QRect, pyqtSignal, QObject, QThread
from PyQt6.QtWidgets import QScrollArea

import threading
import queue
import time
from pathlib import Path


class CameraCanvas(QFrame):
    """Drawing canvas for camera input"""
    
    def __init__(self, width=240, height=240):
        super().__init__()
        self.width = width
        self.height = height
        self.image = QImage(width, height, QImage.Format.Format_RGB32)
        self.image.fill(QColor(255, 255, 255))  # White background
        
        # Draw initial circle at top left
        painter = QPainter(self.image)
        painter.setBrush(QBrush(QColor(0, 0, 0)))
        painter.setPen(QPen(QColor(0, 0, 0)))
        painter.drawEllipse(20, 20, 40, 40)  # Circle at (20,20) with radius ~20
        
        self.drawing = False
        self.last_pos = None
        self.pen_size = 3
        self.pen_color = QColor(0, 0, 0)
        self.flip_h = False
        self.flip_v = False
        
        self.setMinimumSize(width, height)
        self.setMaximumSize(width, height)
        self.setStyleSheet("border: 1px solid black;")
        self.setMouseTracking(True)
    
    def paintEvent(self, event):
        """Paint the canvas with current image"""
        painter = QPainter(self)
        painter.drawImage(0, 0, self.image)
    
    def mousePressEvent(self, event):
        """Start drawing"""
        if event.button() == Qt.MouseButton.LeftButton:
            self.drawing = True
            self.last_pos = event.pos()
    
    def mouseReleaseEvent(self, event):
        """Stop drawing"""
        if event.button() == Qt.MouseButton.LeftButton:
            self.drawing = False
            self.last_pos = None
    
    def mouseMoveEvent(self, event):
        """Draw line from last position to current"""
        if self.drawing and self.last_pos is not None:
            painter = QPainter(self.image)
            painter.setPen(QPen(self.pen_color, self.pen_size, Qt.PenStyle.SolidLine, Qt.PenCapStyle.RoundCap))
            painter.drawLine(self.last_pos, event.pos())
            self.last_pos = event.pos()
            self.update()
    
    def clear_canvas(self):
        """Clear the canvas"""
        self.image.fill(QColor(255, 255, 255))
        self.update()
    
    def set_pen_color(self, color):
        """Set pen color"""
        self.pen_color = color
    
    def set_pen_size(self, size):
        """Set pen size"""
        self.pen_size = size
    
    def get_image_array(self):
        """Get image as RGB numpy array (8-bit per channel), with optional flips applied"""
        # Convert QImage to numpy array
        width = self.image.width()
        height = self.image.height()
        ptr = self.image.bits()
        ptr.setsize(self.image.sizeInBytes())
        arr = np.array(ptr).reshape(height, width, 4)  # RGBA
        rgb = arr[:, :, :3]  # RGB only
        if self.flip_h:
            rgb = np.flip(rgb, axis=1)
        if self.flip_v:
            rgb = np.flip(rgb, axis=0)
        return rgb


class VGADisplay(QFrame):
    """Display for VGA output"""
    
    def __init__(self, width=160, height=240):
        super().__init__()
        self.width = width
        self.height = height
        self.scale = 1
        self.display_image = QImage(width, height, QImage.Format.Format_RGB32)
        self.display_image.fill(QColor(0, 0, 0))  # Black background
        self.pixel_buffer = None
        self.flip_h = False
        self.flip_v = False
        
        # Each logical pixel is 4x wide × 2x tall in physical VGA pixels,
        # so display 2× wider than the logical pixel count to maintain 4:3.
        self.setMinimumSize(width * 2 * self.scale, height * self.scale)
        self.setMaximumSize(width * 2 * self.scale, height * self.scale)
        self.setStyleSheet("border: 2px solid green;")
    
    def set_scale(self, scale):
        self.scale = scale
        self.setMinimumSize(self.width * 2 * scale, self.height * scale)
        self.setMaximumSize(self.width * 2 * scale, self.height * scale)
        self.update()
    
    def paintEvent(self, event):
        """Paint the VGA display, correcting for VGA pixel aspect ratio (4:3)"""
        painter = QPainter(self)
        painter.drawImage(QRect(0, 0, self.width * 2 * self.scale, self.height * self.scale),
                          self.display_image)
    
    def update_from_rgb444(self, frame_data):
        """Update display from RGB444 frame data (16-bit addresses and pixel data)
        
        Args:
            frame_data: dict with {addr: rgb444_value} pairs
        """
        if frame_data is None or len(frame_data) == 0:
            return
        
        self.display_image.fill(QColor(0, 0, 0))  # clear before redrawing
        
        # Draw all pixels in the new frame
        for addr, rgb444 in frame_data.items():
            y = (addr >> 8) & 0xFF
            x = addr & 0xFF
            
            # Convert RGB444 to RGB888
            r = ((rgb444 >> 8) & 0xF) * 17
            g = ((rgb444 >> 4) & 0xF) * 17
            b = (rgb444 & 0xF) * 17
            
            # Apply flips
            px = (self.width - 1 - x) if self.flip_h else x
            py = (self.height - 1 - y) if self.flip_v else y
            
            # Set pixel if within bounds
            if 0 <= px < self.width and 0 <= py < self.height:
                self.display_image.setPixel(px, py, QColor(r, g, b).rgb())
        
        self.update()


class UARTTerminal(QTextEdit):
    """UART terminal display and command input"""
    
    def __init__(self):
        super().__init__()
        self.setReadOnly(True)
        self.setFont(QFont("Courier", 10))
        self.command_queue = queue.Queue()
        self.setMinimumHeight(200)
    
    def add_output(self, text, color="black"):
        """Add output text"""
        self.moveCursor(QTextCursor.MoveOperation.End)
        
        format = self.currentCharFormat()
        format.setForeground(QColor(color))
        self.setCurrentCharFormat(format)
        
        self.insertPlainText(text)
        self.moveCursor(QTextCursor.MoveOperation.End)
        self.ensureCursorVisible()
    
    def add_command(self, cmd):
        """Add command to queue"""
        self.add_output(f"> {cmd}\n", "blue")
        self.command_queue.put(cmd)



class QuickDrawSimulator(QMainWindow):
    """Main simulation GUI window"""
    
    def __init__(self):
        super().__init__()
        self.setWindowTitle("QuickDraw FPGA Simulator")
        self.setGeometry(100, 100, 770, 700)
        
        # Create central widget
        central = QWidget()
        self.setCentralWidget(central)
        layout = QHBoxLayout(central)
        
        # Left side: Input canvas
        left_layout = QVBoxLayout()
        left_layout.addWidget(QLabel("Camera Input (Draw here)"))
        self.camera = CameraCanvas(160, 240)
        left_layout.addWidget(self.camera)
        
        # Clear button
        clear_btn = QPushButton("Clear Canvas")
        clear_btn.clicked.connect(self.camera.clear_canvas)
        left_layout.addWidget(clear_btn)
        
        # Camera flip checkboxes
        cam_flip_row = QHBoxLayout()
        self.cam_flip_h_cb = QCheckBox("Flip H")
        self.cam_flip_v_cb = QCheckBox("Flip V")
        self.cam_flip_h_cb.toggled.connect(lambda v: setattr(self.camera, 'flip_h', v))
        self.cam_flip_v_cb.toggled.connect(lambda v: setattr(self.camera, 'flip_v', v))
        self.cam_flip_v_cb.setChecked(True)  # flip V by default
        cam_flip_row.addWidget(QLabel("Camera:"))
        cam_flip_row.addWidget(self.cam_flip_h_cb)
        cam_flip_row.addWidget(self.cam_flip_v_cb)
        cam_flip_row.addStretch()
        left_layout.addLayout(cam_flip_row)
        
        # VCD trace checkbox
        self.vcd_checkbox = QCheckBox("Enable VCD Trace")
        self.vcd_checkbox.setChecked(False)
        left_layout.addWidget(self.vcd_checkbox)
        
        # Initialize / Restart simulation button
        self.init_btn = QPushButton("Initialize Simulation")
        self.init_btn.clicked.connect(self.on_init_simulation)
        left_layout.addWidget(self.init_btn)
        
        # Stop button
        stop_btn = QPushButton("Stop && Flush VCD")
        stop_btn.clicked.connect(self.on_stop_simulation)
        left_layout.addWidget(stop_btn)
        
        left_frame = QFrame()
        left_frame.setLayout(left_layout)
        
        # Right side: Output display and UART
        right_layout = QVBoxLayout()
        right_layout.addWidget(QLabel("VGA Output"))
        self.vga_display = VGADisplay(160, 240)
        right_layout.addWidget(self.vga_display)
        
        flip_row = QHBoxLayout()
        self.flip_h_cb = QCheckBox("Flip H")
        self.flip_v_cb = QCheckBox("Flip V")
        self.flip_h_cb.toggled.connect(lambda v: setattr(self.vga_display, 'flip_h', v))
        self.flip_v_cb.toggled.connect(lambda v: setattr(self.vga_display, 'flip_v', v))
        self.flip_v_cb.setChecked(True)  # VGA y-axis is inverted by default
        flip_row.addWidget(self.flip_h_cb)
        flip_row.addWidget(self.flip_v_cb)
        flip_row.addStretch()
        right_layout.addLayout(flip_row)
        
        scale_row = QHBoxLayout()
        scale_row.addWidget(QLabel("Scale:"))
        self.scale_slider = QSlider(Qt.Orientation.Horizontal)
        self.scale_slider.setMinimum(1)
        self.scale_slider.setMaximum(4)
        self.scale_slider.setValue(1)
        self.scale_slider.setTickPosition(QSlider.TickPosition.TicksBelow)
        self.scale_slider.setTickInterval(1)
        self.scale_slider.setFixedWidth(100)
        self.scale_label = QLabel("2x")
        self.scale_slider.valueChanged.connect(self._on_scale_changed)
        scale_row.addWidget(self.scale_slider)
        scale_row.addWidget(self.scale_label)
        scale_row.addStretch()
        right_layout.addLayout(scale_row)
        
        uart_header_row = QHBoxLayout()
        uart_header_row.addWidget(QLabel("UART Control"))
        uart_header_row.addStretch()
        self.clear_uart_btn = QPushButton("Clear Log")
        self.clear_uart_btn.clicked.connect(self._clear_uart_log)
        uart_header_row.addWidget(self.clear_uart_btn)
        right_layout.addLayout(uart_header_row)

        self.uart_terminal = UARTTerminal()
        right_layout.addWidget(self.uart_terminal)

        # Command buttons
        cmd_grid = QGridLayout()
        cmd_grid.setSpacing(3)

        def _btn(label, cmd, tooltip=""):
            b = QPushButton(label)
            b.setFixedSize(40, 28)
            if tooltip:
                b.setToolTip(tooltip)
            b.clicked.connect(lambda: self._send_uart_cmd(cmd))
            return b

        # ROI movement (arrow pad layout)
        cmd_grid.addWidget(QLabel("ROI:"), 0, 0)
        cmd_grid.addWidget(_btn("↑", '\x1b[A', "ROI up"),    0, 2)
        cmd_grid.addWidget(_btn("←", '\x1b[D', "ROI left"),  1, 1)
        cmd_grid.addWidget(_btn("↓", '\x1b[B', "ROI down"),  1, 2)
        cmd_grid.addWidget(_btn("→", '\x1b[C', "ROI right"), 1, 3)

        # ROI size
        cmd_grid.addWidget(QLabel("Size:"), 0, 5)
        cmd_grid.addWidget(_btn("S", 's', "Small"),  0, 6)
        cmd_grid.addWidget(_btn("M", 'm', "Medium"), 0, 7)
        cmd_grid.addWidget(_btn("L", 'l', "Large"),  0, 8)

        # Threshold
        cmd_grid.addWidget(QLabel("Thr:"), 1, 5)
        cmd_grid.addWidget(_btn("+", '+', "Threshold +"), 1, 6)
        cmd_grid.addWidget(_btn("-", '-', "Threshold -"), 1, 7)

        # Status
        cmd_grid.addWidget(_btn("?", '?', "Status"), 1, 8)

        right_layout.addLayout(cmd_grid)

        # Freeform UART input (send on Enter)
        uart_input_row = QHBoxLayout()
        uart_input_row.addWidget(QLabel("UART TX:"))
        self.uart_input = QLineEdit()
        self.uart_input.setPlaceholderText("Type text/escape sequence and press Enter")
        self.uart_input.returnPressed.connect(self._on_uart_text_entered)
        uart_input_row.addWidget(self.uart_input)
        right_layout.addLayout(uart_input_row)
        
        # Counters and status
        right_layout.addWidget(QLabel("Status"))
        self.cycle_label = QLabel("Cycle: 0")
        self.cycle_label.setFont(QFont("Courier", 9))
        right_layout.addWidget(self.cycle_label)
        
        self.camera_label = QLabel("Camera: idle")
        self.camera_label.setFont(QFont("Courier", 9))
        right_layout.addWidget(self.camera_label)
        
        self.vga_label = QLabel("VGA: idle")
        self.vga_label.setFont(QFont("Courier", 9))
        right_layout.addWidget(self.vga_label)
        
        right_frame = QFrame()
        right_frame.setLayout(right_layout)
        
        # Add both to main layout
        layout.addWidget(left_frame)
        layout.addWidget(right_frame)
        
        # Simulation state
        self.simulator_thread = None
        self.running = False
        
        # UART command queue
        self.uart_queue = queue.Queue()
        
        self.uart_terminal.add_output("QuickDraw FPGA Simulator\n", "green")
        self.uart_terminal.add_output("Click 'Initialize Simulation' to start.\n", "green")
        self.uart_terminal.add_output("Keys: ←→↑↓=move ROI  S/M/L=size  +/-=threshold  ?=status\n", "green")
    
    def _send_uart_cmd(self, cmd):
        """Send a UART command string"""
        self.uart_queue.put(cmd)
        self.uart_terminal.add_output("[cmd] ", "blue")
        self.uart_terminal.add_output(cmd, "blue")
        self.uart_terminal.add_output("\n", "blue")

    def _on_uart_text_entered(self):
        """Send freeform UART text when Enter is pressed"""
        text = self.uart_input.text()
        if text:
            decoded_text = self._decode_uart_escapes(text)
            self._send_uart_cmd(decoded_text)
            self.uart_input.clear()

    def _clear_uart_log(self):
        """Clear UART log display"""
        self.uart_terminal.clear()

    def _decode_uart_escapes(self, text):
        """Decode common escaped sequences entered in the UART text field.

        Examples: \\n, \\r, \\t, \\x1b
        """
        try:
            return bytes(text, "utf-8").decode("unicode_escape")
        except Exception:
            return text

    def _decode_uart_output_escapes(self, text):
        """Decode escaped UART output like '\\x0a' into actual characters."""
        try:
            return bytes(text, "utf-8").decode("unicode_escape")
        except Exception:
            return text
    
    def _on_scale_changed(self, value):
        self.scale_label.setText(f"{value}x")
        self.vga_display.set_scale(value)
    
    def _start_simulator(self):
        """Start the simulator thread"""
        enable_vcd = self.vcd_checkbox.isChecked()
        self.simulator_thread = SimulatorWorker(self.camera, self.uart_queue,
                                                enable_vcd_trace=enable_vcd)
        self.simulator_thread.vga_updated.connect(self.on_vga_update)
        self.simulator_thread.uart_output.connect(self.on_uart_output)
        self.simulator_thread.counters_updated.connect(self.on_counters_update)
        self.simulator_thread.error.connect(self.on_simulator_error)
        self.simulator_thread.start()
        vcd_msg = " (VCD trace ON)" if enable_vcd else ""
        self.uart_terminal.add_output(f"Simulator started{vcd_msg}\n", "green")
    
    def on_init_simulation(self):
        """Initialize or restart the simulation"""
        # Stop any running simulation first
        if self.simulator_thread and self.simulator_thread.isRunning():
            self.uart_terminal.add_output("Stopping previous simulation...\n", "green")
            self.simulator_thread.stop()
            self.simulator_thread.wait(10000)
        self.running = True
        self.uart_queue = queue.Queue()  # flush stale UART commands
        self.vga_display.display_image.fill(QColor(0, 0, 0))
        self.vga_display.update()
        self._start_simulator()
    
    def on_uart_command(self, cmd):
        """Handle UART command"""
        self.uart_queue.put(cmd)
        self.uart_terminal.add_output(f"> {cmd}\n", "blue")
    
    def on_stop_simulation(self):
        """Stop simulation and flush VCD trace"""
        print("\n=== Stopping simulation and flushing VCD ===")
        self.running = False
        if self.simulator_thread and hasattr(self.simulator_thread, 'stop'):
            self.simulator_thread.stop()
        self.uart_terminal.add_output("Simulator stopped and VCD flushed.\n", "green")
    
    def on_vga_update(self, vga_frame):
        """Update VGA display"""
        self.vga_display.update_from_rgb444(vga_frame)
    
    def on_counters_update(self, cycle, cam_status, vga_status):
        """Update counter labels"""
        self.cycle_label.setText(f"Cycle: {cycle}")
        self.camera_label.setText(cam_status)
        self.vga_label.setText(vga_status)
    
    def on_uart_output(self, output):
        """Receive UART output"""
        self.uart_terminal.add_output(self._decode_uart_output_escapes(output), "red")
    
    def on_simulator_error(self, error_msg):
        """Handle simulator error"""
        self.uart_terminal.add_output(f"ERROR: {error_msg}\n", "red")
    
    def closeEvent(self, event):
        """Clean up on close"""
        self.running = False
        if self.simulator_thread:
            self.simulator_thread.stop()
            self.simulator_thread.wait(5000)
        event.accept()


class SimulatorWorker(QThread):
    """Worker thread for simulation"""
    
    vga_updated = pyqtSignal(dict)
    uart_output = pyqtSignal(str)
    counters_updated = pyqtSignal(int, str, str)  # cycle, camera_status, vga_status
    error = pyqtSignal(str)
    
    def __init__(self, camera_canvas, uart_input_queue, enable_vcd_trace=False):
        super().__init__()
        self.camera_canvas = camera_canvas
        self.uart_input_queue = uart_input_queue
        self.enable_vcd_trace = enable_vcd_trace
        self.running = False
    
    def run(self):
        """Run simulation loop"""
        try:
            try:
                from sim_ctypes import create_simulator
                print("Using fast C++ backend (sim_ctypes)")
            except Exception as e:
                print(f"C++ backend unavailable ({e}), falling back to Python backend")
                from sim_verilator import create_simulator

            # Create simulator with optional VCD tracing
            self.simulator = create_simulator(
                hdl_path=Path(__file__).parent,
                enable_vcd_trace=self.enable_vcd_trace,
                vcd_file="sim_trace.vcd"
            )

            self.running = True
            frame_count = 0

            while self.running:
                # Get camera frame from canvas and queue it for streaming
                camera_frame = self.camera_canvas.get_image_array()
                if camera_frame is not None:
                    self.simulator.submit_camera_frame(camera_frame)
                
                # Get UART commands from queue
                while not self.uart_input_queue.empty():
                    try:
                        cmd = self.uart_input_queue.get_nowait()
                        self.simulator.send_uart_command(cmd)
                    except queue.Empty:
                        break
                
                # Step simulation
                self.simulator.step(100000)  # Step 1000 cycles per iteration
                
                # Get outputs
                vga_frame = self.simulator.get_vga_output()
                if vga_frame:
                    self.vga_updated.emit(vga_frame)
                
                uart_out = self.simulator.get_uart_output()
                if uart_out:
                    self.uart_output.emit(uart_out)
                
                # Emit counter updates
                cam_state = self.simulator._cam_state
                cam_status = f"Camera: {cam_state} (frames: {self.simulator._cam_frames_sent})"
                if cam_state == 'pixel':
                    cam_status += f" y={self.simulator._cam_y}/{self.simulator._cam_height} x={self.simulator._cam_x}/{self.simulator._cam_width}"
                elif cam_state in ('row_end_pulse', 'frame_end_pulse'):
                    cam_status += f" y={self.simulator._cam_y}/{self.simulator._cam_height}"
                
                vga_pixels = len(self.simulator._vga_current_frame)
                vga_status = f"VGA: {self.simulator._vga_frames_received} frames, {vga_pixels} px in progress"
                
                self.counters_updated.emit(self.simulator.cycle, cam_status, vga_status)
                
                frame_count += 1
                time.sleep(0.02)  # ~50Hz update rate
        
        except Exception as e:
            print(f"Simulator error: {e}")
            import traceback
            traceback.print_exc()
            self.error.emit(str(e))
    
    def stop(self):
        """Stop simulation"""
        self.running = False
        if hasattr(self, 'simulator'):
            self.simulator.stop()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = QuickDrawSimulator()
    window.show()
    sys.exit(app.exec())
