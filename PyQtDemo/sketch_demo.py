import sys
import numpy as np
from pathlib import Path
import pyverilator
from PyQt6.QtWidgets import (
    QApplication,
    QButtonGroup,
    QCheckBox,
    QFileDialog,
    QGroupBox,
    QHBoxLayout,
    QLabel,
    QLineEdit,
    QMainWindow,
    QMessageBox,
    QPushButton,
    QPlainTextEdit,
    QRadioButton,
    QVBoxLayout,
    QWidget,
)

try:
    from fpga_uart import FPGAUARTInference
    FPGA_AVAILABLE = True
except ImportError:
    FPGA_AVAILABLE = False
from PyQt6.QtGui import QPainter, QPen, QImage
from PyQt6.QtCore import Qt, QPoint, QTimer

import matplotlib.pyplot as plt
from matplotlib.backends.backend_qtagg import FigureCanvasQTAgg as FigureCanvas

CLASSES = ["bicycle", "eyeglasses", "car", "eye", "tree", "apple", "smiley_face", "cell_phone", "airplane", "book"]


def to_signed32(value):
    if value & 0x80000000:
        return value - (1 << 32)
    return value


def pack_binary_image_to_inp(gray_1x1x28x28, threshold=0.5):
    # Flatten in row-major order and map each pixel to one input bit.
    flat = (gray_1x1x28x28[0, 0].reshape(-1) > threshold).astype(np.uint8)
    packed = 0
    for i, bit in enumerate(flat):
        if bit:
            packed |= (1 << i)
    return packed


def unpack_scores(scores_flat):
    scores = []
    for i in range(10):
        raw = (scores_flat >> (32 * i)) & 0xFFFFFFFF
        scores.append(to_signed32(raw))
    return np.array(scores, dtype=np.float32)

class DrawingWidget(QWidget):
    def __init__(self, update_callback):
        super().__init__()
        self.setFixedSize(280, 280)
        self.image = QImage(self.size(), QImage.Format.Format_RGB32)
        self.image.fill(Qt.GlobalColor.black)  # black background
        
        self.drawing = False
        self.last_point = QPoint()
        self.update_callback = update_callback
        
        self.timer = QTimer()
        self.timer.timeout.connect(self.trigger_update)
        self.timer.setSingleShot(True)
        
    def clear(self):
        self.image.fill(Qt.GlobalColor.black)
        self.update()
        self.update_callback(self.get_image_array())
        
    def mousePressEvent(self, event):
        if event.button() == Qt.MouseButton.LeftButton:
            self.drawing = True
            self.last_point = event.pos()
            
    def mouseMoveEvent(self, event):
        if (event.buttons() & Qt.MouseButton.LeftButton) and self.drawing:
            painter = QPainter(self.image)
            painter.setPen(QPen(Qt.GlobalColor.white, 15, Qt.PenStyle.SolidLine, Qt.PenCapStyle.RoundCap, Qt.PenJoinStyle.RoundJoin))
            painter.drawLine(self.last_point, event.pos())
            self.last_point = event.pos()
            self.update()
            
            # Reset timer to update prediction shortly after the stroke
            self.timer.start(50) 
            
    def mouseReleaseEvent(self, event):
        if event.button() == Qt.MouseButton.LeftButton:
            self.drawing = False
            self.trigger_update()
            
    def paintEvent(self, event):
        canvas_painter = QPainter(self)
        canvas_painter.drawImage(self.rect(), self.image, self.image.rect())
        
    def trigger_update(self):
        img_array = self.get_image_array()
        self.update_callback(img_array)
        
    def get_image_array(self):
        # Scale to 28x28 for model input.
        scaled_img = self.image.scaled(28, 28, Qt.AspectRatioMode.IgnoreAspectRatio, Qt.TransformationMode.SmoothTransformation)
        
        gray = np.zeros((28, 28), dtype=np.float32)
        for y in range(28):
            for x in range(28):
                gray[y, x] = scaled_img.pixelColor(x, y).red() / 255.0
        
        # Expand dims for batch and channel: (1, 1, 28, 28).
        gray = np.expand_dims(gray, axis=(0, 1))
        return gray

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("EmLogic Sketch Recognition Demo")

        self.verilog_status_label = None
        self.verilog_path_label = None
        self.verilog_path_input = None
        self.btn_browse_verilog = None
        self.btn_load_verilog = None

        # Inference backend state
        self.backend = 'verilator'   # 'verilator' | 'fpga'
        self.fpga_uart = None        # FPGAUARTInference instance (or None)

        # Build and load the default Verilog model using pyverilator.
        project_root = Path(__file__).resolve().parents[1]
        self.verilog_path = project_root / "verilog" / "mlp_quickdraw_4k_4k.v"
        self.sim = None

        # Central widget
        central = QWidget()
        layout = QHBoxLayout()
        central.setLayout(layout)
        self.setCentralWidget(central)

        # Left side layout
        left_layout = QVBoxLayout()

        # ------------------------------------------------------------------
        # Backend selector group box
        # ------------------------------------------------------------------
        backend_group = QGroupBox("Inference Backend")
        backend_layout = QVBoxLayout()
        backend_group.setLayout(backend_layout)

        self.radio_verilator = QRadioButton("Verilator (simulation)")
        self.radio_fpga      = QRadioButton("FPGA via UART")
        self.radio_verilator.setChecked(True)
        if not FPGA_AVAILABLE:
            self.radio_fpga.setEnabled(False)
            self.radio_fpga.setToolTip("pyserial not installed – run: pip install pyserial")

        self._backend_group = QButtonGroup()
        self._backend_group.addButton(self.radio_verilator)
        self._backend_group.addButton(self.radio_fpga)
        self._backend_group.buttonClicked.connect(self.on_backend_changed)

        radio_row = QHBoxLayout()
        radio_row.addWidget(self.radio_verilator)
        radio_row.addWidget(self.radio_fpga)
        backend_layout.addLayout(radio_row)

        # UART port row (only active when FPGA backend is selected)
        uart_row = QHBoxLayout()
        uart_row.addWidget(QLabel("Port:"))
        self.uart_port_input = QLineEdit("/dev/ttyACM0")
        self.uart_port_input.setFixedWidth(140)
        uart_row.addWidget(self.uart_port_input)
        self.btn_uart_connect = QPushButton("Connect")
        self.btn_uart_connect.clicked.connect(self.on_uart_connect_toggle)
        uart_row.addWidget(self.btn_uart_connect)
        uart_row.addStretch()
        backend_layout.addLayout(uart_row)

        self.uart_status_label = QLabel("")
        backend_layout.addWidget(self.uart_status_label)

        self.uart_console = QPlainTextEdit()
        self.uart_console.setReadOnly(True)
        self.uart_console.setPlaceholderText("UART console: raw TX/RX bytes will appear here when FPGA backend is connected")
        self.uart_console.document().setMaximumBlockCount(300)
        backend_layout.addWidget(self.uart_console)

        left_layout.addWidget(backend_group)
        self._set_uart_controls_visible(False)

        # ------------------------------------------------------------------
        # Verilator path row
        # ------------------------------------------------------------------
        path_row = QHBoxLayout()
        self.verilog_path_label = QLabel("Verilog:")
        path_row.addWidget(self.verilog_path_label)
        self.verilog_path_input = QLineEdit(str(self.verilog_path))
        self.verilog_path_input.returnPressed.connect(self.on_apply_verilog_path)
        path_row.addWidget(self.verilog_path_input)

        self.btn_browse_verilog = QPushButton("Browse")
        self.btn_browse_verilog.clicked.connect(self.on_browse_verilog)
        path_row.addWidget(self.btn_browse_verilog)

        self.btn_load_verilog = QPushButton("Load")
        self.btn_load_verilog.clicked.connect(self.on_apply_verilog_path)
        path_row.addWidget(self.btn_load_verilog)
        left_layout.addLayout(path_row)

        self.verilog_status_label = QLabel()
        left_layout.addWidget(self.verilog_status_label)
        self.set_verilog_status("Not loaded (press Load)", "gray")

        self.drawing_widget = DrawingWidget(self.on_draw_update)
        left_layout.addWidget(self.drawing_widget)
        
        self.btn_clear = QPushButton("Clear Canvas")
        self.btn_clear.clicked.connect(self.drawing_widget.clear)
        left_layout.addWidget(self.btn_clear)

        self.chk_softmax = QCheckBox("Apply Softmax")
        self.chk_softmax.setChecked(True)
        self.chk_softmax.stateChanged.connect(self.on_softmax_toggled)
        left_layout.addWidget(self.chk_softmax)
        left_layout.addStretch()
        
        layout.addLayout(left_layout)
        
        # Right side layout (Matplotlib)
        self.figure, self.ax = plt.subplots(figsize=(6, 4))
        self.canvas = FigureCanvas(self.figure)
        layout.addWidget(self.canvas)
        
        self.init_plot()
        self._set_backend_visibility()
        self.drawing_widget.clear() # trigger initial plot 

    # ------------------------------------------------------------------
    # Backend switching helpers
    # ------------------------------------------------------------------

    def _set_uart_controls_visible(self, visible: bool) -> None:
        self.uart_port_input.setEnabled(visible)
        self.btn_uart_connect.setEnabled(visible)

    def _set_backend_visibility(self) -> None:
        is_verilator = self.backend == 'verilator'

        # Verilator-specific widgets
        if self.verilog_path_label is not None:
            self.verilog_path_label.setVisible(is_verilator)
        if self.verilog_path_input is not None:
            self.verilog_path_input.setVisible(is_verilator)
        if self.btn_browse_verilog is not None:
            self.btn_browse_verilog.setVisible(is_verilator)
        if self.btn_load_verilog is not None:
            self.btn_load_verilog.setVisible(is_verilator)
        if self.verilog_status_label is not None:
            self.verilog_status_label.setVisible(is_verilator)

        # FPGA-specific console
        if self.uart_console is not None:
            self.uart_console.setVisible(not is_verilator)

    def _append_uart_console(self, line: str) -> None:
        self.uart_console.appendPlainText(line)

    def _format_uart_bytes(self, data: bytes) -> str:
        return " ".join(f"{b:02X}" for b in data)

    def on_backend_changed(self, button) -> None:
        if button is self.radio_verilator:
            self.backend = 'verilator'
            self._disconnect_fpga()
            self._set_uart_controls_visible(False)
            self.set_verilog_controls_enabled(True)
        else:
            self.backend = 'fpga'
            self.set_verilog_controls_enabled(False)
            self._set_uart_controls_visible(True)
        self._set_backend_visibility()
        # Clear bars when switching backend
        self.on_draw_update(self.drawing_widget.get_image_array())

    def on_uart_connect_toggle(self) -> None:
        if self.fpga_uart is not None and self.fpga_uart.is_open():
            self._disconnect_fpga()
        else:
            self._connect_fpga()

    def _connect_fpga(self) -> None:
        port = self.uart_port_input.text().strip()
        try:
            self.fpga_uart = FPGAUARTInference(port=port)
            self.fpga_uart.open()
            self.uart_status_label.setText(f"Connected: {port}")
            self.uart_status_label.setStyleSheet("color: green;")
            self.btn_uart_connect.setText("Disconnect")
            self.uart_port_input.setEnabled(False)
            self._append_uart_console(f"[INFO] Connected to {port}")
        except Exception as e:
            self.fpga_uart = None
            self.uart_status_label.setText(f"Failed: {e}")
            self.uart_status_label.setStyleSheet("color: red;")
            self._append_uart_console(f"[ERROR] Connect failed on {port}: {e}")
            QMessageBox.critical(self, "UART Error",
                                 f"Could not open {port}:\n{e}")

    def _disconnect_fpga(self) -> None:
        if self.fpga_uart is not None:
            port = self.fpga_uart.port
            self.fpga_uart.close()
            self.fpga_uart = None
            self._append_uart_console(f"[INFO] Disconnected from {port}")
        self.uart_status_label.setText("")
        self.btn_uart_connect.setText("Connect")
        self.uart_port_input.setEnabled(self.backend == 'fpga')

    def closeEvent(self, event):
        self._disconnect_fpga()
        super().closeEvent(event)

    # ------------------------------------------------------------------
    # Verilator helpers (unchanged logic)
    # ------------------------------------------------------------------

    def load_simulator(self, verilog_path):
        verilog_path = Path(verilog_path).expanduser().resolve()
        self.sim = pyverilator.PyVerilator.build(str(verilog_path), top_module_name="circuit")
        self.verilog_path = verilog_path

    def set_verilog_status(self, text, color):
        if self.verilog_status_label is not None:
            self.verilog_status_label.setText(f"Model status: {text}")
            self.verilog_status_label.setStyleSheet(f"color: {color};")

    def set_verilog_controls_enabled(self, enabled):
        if self.verilog_path_input is not None:
            self.verilog_path_input.setEnabled(enabled)
        if self.btn_browse_verilog is not None:
            self.btn_browse_verilog.setEnabled(enabled)
        if self.btn_load_verilog is not None:
            self.btn_load_verilog.setEnabled(enabled)

    def on_browse_verilog(self):
        selected, _ = QFileDialog.getOpenFileName(
            self,
            "Select Verilog Model",
            str(self.verilog_path.parent),
            "Verilog Files (*.v);;All Files (*)",
        )
        if selected:
            self.verilog_path_input.setText(selected)
            self.on_apply_verilog_path()

    def on_apply_verilog_path(self):
        candidate_path = Path(self.verilog_path_input.text().strip())
        if not candidate_path.exists():
            self.set_verilog_status("File not found", "red")
            QMessageBox.warning(self, "Invalid Path", f"Verilog file not found:\n{candidate_path}")
            return

        previous_sim = self.sim
        previous_path = self.verilog_path
        self.set_verilog_controls_enabled(False)
        self.set_verilog_status("Compiling...", "orange")
        QApplication.processEvents()
        try:
            self.load_simulator(candidate_path)
            print(f"Loaded Verilog model: {self.verilog_path}")
            self.set_verilog_status("Done", "green")
        except Exception as e:
            self.sim = previous_sim
            self.verilog_path = previous_path
            self.verilog_path_input.setText(str(previous_path))
            self.set_verilog_status("Compile/load failed", "red")
            QMessageBox.critical(self, "Load Error", f"Failed to load Verilog model:\n{e}")
        finally:
            self.set_verilog_controls_enabled(True)

    def on_softmax_toggled(self):
        self.on_draw_update(self.drawing_widget.get_image_array())

    def init_plot(self):
        self.ax.clear()
        self.bars = self.ax.barh(CLASSES, np.zeros(10), color='skyblue')
        self.ax.set_xlim(0, 1)
        self.ax.set_xlabel('Probability')
        self.ax.set_title('Live Prediction')
        self.ax.invert_yaxis()  # to match the order in CLASSES from top to bottom
        self.figure.tight_layout()
        self.canvas.draw()
        
    def on_draw_update(self, img_array):
        use_softmax = self.chk_softmax.isChecked()
        try:
            inp_value = pack_binary_image_to_inp(img_array)

            if self.backend == 'verilator':
                if self.sim is None:
                    logits = np.zeros(10)
                else:
                    self.sim.io.inp = inp_value
                    logits = unpack_scores(int(self.sim.io.scores_flat))
            else:  # fpga
                if self.fpga_uart is None or not self.fpga_uart.is_open():
                    logits = np.zeros(10)
                else:
                    scores_flat = self.fpga_uart.run_inference(inp_value)
                    tx_bytes = self.fpga_uart.last_tx_bytes
                    rx_bytes = self.fpga_uart.last_rx_bytes
                    self._append_uart_console(f"[TX] {self._format_uart_bytes(tx_bytes)}")
                    self._append_uart_console(f"[RX] {self._format_uart_bytes(rx_bytes)}")
                    logits = unpack_scores(scores_flat)

            if use_softmax:
                exp_logits = np.exp(logits - np.max(logits))
                values = exp_logits / exp_logits.sum()
            else:
                values = logits

        except Exception as e:
            print(f"Inference error: {e}")
            values = np.zeros(10)

        # Update axis limits based on softmax setting
        if use_softmax:
            self.ax.set_xlim(0, 1)
            self.ax.set_xlabel('Probability')
        else:
            self.ax.set_xlim(0, 200)
            self.ax.set_xlabel('Score')

        # Update plot bars
        for bar, val in zip(self.bars, values):
            bar.set_width(val)
        self.canvas.draw()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())
