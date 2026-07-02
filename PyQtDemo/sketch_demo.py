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
from PyQt6.QtGui import QPainter, QPen, QImage, QColor, QBrush, QIntValidator
from PyQt6.QtCore import Qt, QPoint, QObject, QThread, pyqtSignal

import matplotlib.pyplot as plt
from matplotlib.backends.backend_qtagg import FigureCanvasQTAgg as FigureCanvas

CLASSES = ["bicycle", "eyeglasses", "car", "eye", "tree", "apple", "smiley_face", "cell_phone", "airplane", "book"]
CLASS_COLORS_HEX = [
    "#e63946",
    "#f4a261",
    "#e9c46a",
    "#2a9d8f",
    "#457b9d",
    "#264653",
    "#8ab17d",
    "#6d597a",
    "#ff6b6b",
    "#00b4d8",
]


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


class VerilatorLoadWorker(QObject):
    finished = pyqtSignal(object, str, str)
    failed = pyqtSignal(str)

    def __init__(self, *, use_prebuilt_so: bool, so_path: str | None, verilog_path: str | None,
                 build_dir: str | None, top_module_name: str):
        super().__init__()
        self.use_prebuilt_so = use_prebuilt_so
        self.so_path = so_path
        self.verilog_path = verilog_path
        self.build_dir = build_dir
        self.top_module_name = top_module_name

    def run(self):
        try:
            if self.use_prebuilt_so:
                resolved_so_path = Path(self.so_path).expanduser().resolve()
                sim = pyverilator.PyVerilator(str(resolved_so_path), auto_eval=True)
                self.finished.emit(sim, str(resolved_so_path), "prebuilt")
                return

            resolved_verilog_path = Path(self.verilog_path).expanduser().resolve()
            resolved_build_dir = Path(self.build_dir).expanduser().resolve()
            resolved_build_dir.mkdir(parents=True, exist_ok=True)
            cached_lib = resolved_build_dir / f"V{self.top_module_name}"

            should_rebuild = True
            if cached_lib.exists():
                try:
                    should_rebuild = cached_lib.stat().st_mtime < resolved_verilog_path.stat().st_mtime
                except OSError:
                    should_rebuild = True

            if should_rebuild:
                sim = pyverilator.PyVerilator.build(
                    str(resolved_verilog_path),
                    top_module_name=self.top_module_name,
                    build_dir=str(resolved_build_dir),
                )
                self.finished.emit(sim, str(resolved_verilog_path), "compiled")
            else:
                sim = pyverilator.PyVerilator(str(cached_lib), auto_eval=True)
                self.finished.emit(sim, str(resolved_verilog_path), "cached")
        except Exception as exc:
            self.failed.emit(str(exc))

class DrawingWidget(QWidget):
    def __init__(self):
        super().__init__()
        self.setFixedSize(640, 480)
        self.image = QImage(self.size(), QImage.Format.Format_RGB32)
        self.image.fill(Qt.GlobalColor.black)  # black background
        self.overlay_windows = []
        self.class_colors = [QColor(hex_color) for hex_color in CLASS_COLORS_HEX]
        
        self.drawing = False
        self.last_point = QPoint()
        
    def clear(self):
        self.image.fill(Qt.GlobalColor.black)
        self.overlay_windows = []
        self.update()

    def set_overlay_windows(self, windows):
        self.overlay_windows = windows
        self.update()
        
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
            
    def mouseReleaseEvent(self, event):
        if event.button() == Qt.MouseButton.LeftButton:
            self.drawing = False
            
    def paintEvent(self, event):
        canvas_painter = QPainter(self)
        canvas_painter.drawImage(self.rect(), self.image, self.image.rect())

        for x, y, w, h, class_idx in self.overlay_windows:
            color = self.class_colors[class_idx % len(self.class_colors)]
            fill = QColor(color)
            fill.setAlpha(70)
            border = QColor(color)
            border.setAlpha(210)

            canvas_painter.setPen(QPen(border, 2))
            canvas_painter.setBrush(QBrush(fill))
            canvas_painter.drawRect(x, y, w, h)
            canvas_painter.setPen(QPen(Qt.GlobalColor.white, 1))
            canvas_painter.drawText(x + 4, y + 16, CLASSES[class_idx])
        
    def get_full_image_array(self):
        width = self.image.width()
        height = self.image.height()
        gray = np.zeros((height, width), dtype=np.float32)
        for y in range(height):
            for x in range(width):
                gray[y, x] = self.image.pixelColor(x, y).red() / 255.0

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
        self.chk_use_prebuilt_so = None
        self.prebuilt_so_path_label = None
        self.prebuilt_so_path_input = None
        self.btn_browse_prebuilt_so = None
        self.verilator_load_thread = None
        self.verilator_load_worker = None
        self._previous_sim_before_load = None
        self._previous_path_before_load = None
        self._pending_prebuilt_mode = False
        self.class_colors = [QColor(hex_color) for hex_color in CLASS_COLORS_HEX]

        # Inference backend state
        self.backend = 'verilator'   # 'verilator' | 'fpga'
        self.fpga_uart = None        # FPGAUARTInference instance (or None)

        # Build and load the default Verilog model using pyverilator.
        project_root = Path(__file__).resolve().parents[1]
        self.verilog_path = project_root / "verilog" / "mlp_quickdraw_4k_4k.v"
        self.verilated_cache_root = project_root / "verilated"
        self.top_module_name = "circuit"
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

        so_mode_row = QHBoxLayout()
        self.chk_use_prebuilt_so = QCheckBox("Use prebuilt sim object")
        self.chk_use_prebuilt_so.stateChanged.connect(self.on_verilator_source_mode_changed)
        so_mode_row.addWidget(self.chk_use_prebuilt_so)
        so_mode_row.addStretch()
        left_layout.addLayout(so_mode_row)

        so_path_row = QHBoxLayout()
        self.prebuilt_so_path_label = QLabel("Shared lib:")
        so_path_row.addWidget(self.prebuilt_so_path_label)
        self.prebuilt_so_path_input = QLineEdit("")
        self.prebuilt_so_path_input.returnPressed.connect(self.on_apply_verilog_path)
        so_path_row.addWidget(self.prebuilt_so_path_input)
        self.btn_browse_prebuilt_so = QPushButton("Browse")
        self.btn_browse_prebuilt_so.clicked.connect(self.on_browse_prebuilt_so)
        so_path_row.addWidget(self.btn_browse_prebuilt_so)
        left_layout.addLayout(so_path_row)

        self.verilog_status_label = QLabel()
        left_layout.addWidget(self.verilog_status_label)
        self.set_verilog_status("Not loaded (press Load)", "gray")

        self.drawing_widget = DrawingWidget()
        left_layout.addWidget(self.drawing_widget)

        bbox_group = QGroupBox("Bounding Box Inference")
        bbox_layout = QVBoxLayout()
        bbox_group.setLayout(bbox_layout)

        params_row = QHBoxLayout()
        params_row.addWidget(QLabel("Pixel threshold:"))
        self.pixel_threshold_input = QLineEdit("0.25")
        self.pixel_threshold_input.setFixedWidth(80)
        params_row.addWidget(self.pixel_threshold_input)
        params_row.addWidget(QLabel("Min pixels:"))
        self.min_pixels_input = QLineEdit("80")
        self.min_pixels_input.setValidator(QIntValidator(1, 100000, self))
        self.min_pixels_input.setFixedWidth(80)
        params_row.addWidget(self.min_pixels_input)
        params_row.addWidget(QLabel("Merge gap:"))
        self.merge_gap_input = QLineEdit("20")
        self.merge_gap_input.setValidator(QIntValidator(0, 1000, self))
        self.merge_gap_input.setFixedWidth(80)
        params_row.addWidget(self.merge_gap_input)
        params_row.addStretch()
        bbox_layout.addLayout(params_row)

        self.btn_run_inference = QPushButton("Run Bounding-Box Inference")
        self.btn_run_inference.clicked.connect(self.on_run_bounding_box_inference)
        bbox_layout.addWidget(self.btn_run_inference)

        self.inference_status_label = QLabel("No inference run yet")
        self.inference_status_label.setStyleSheet("color: gray;")
        bbox_layout.addWidget(self.inference_status_label)
        left_layout.addWidget(bbox_group)
        
        self.btn_clear = QPushButton("Clear Canvas")
        self.btn_clear.clicked.connect(self.on_clear_canvas)
        left_layout.addWidget(self.btn_clear)
        left_layout.addStretch()
        
        layout.addLayout(left_layout)
        
        # Right side layout (Matplotlib)
        self.figure, self.ax = plt.subplots(figsize=(6, 4))
        self.canvas = FigureCanvas(self.figure)
        layout.addWidget(self.canvas)
        
        self.init_plot()
        self.on_verilator_source_mode_changed()
        self._set_backend_visibility()
        self.on_clear_canvas()

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
        if self.chk_use_prebuilt_so is not None:
            self.chk_use_prebuilt_so.setVisible(is_verilator)
        if self.prebuilt_so_path_label is not None:
            self.prebuilt_so_path_label.setVisible(is_verilator)
        if self.prebuilt_so_path_input is not None:
            self.prebuilt_so_path_input.setVisible(is_verilator)
        if self.btn_browse_prebuilt_so is not None:
            self.btn_browse_prebuilt_so.setVisible(is_verilator)

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
        self.inference_status_label.setText("Backend changed. Run inference.")
        self.inference_status_label.setStyleSheet("color: gray;")
        self._reset_plot_values()

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
        if self.verilator_load_thread is not None and self.verilator_load_thread.isRunning():
            QMessageBox.information(self, "Please Wait", "Verilator is still building/loading. Try closing again after it finishes.")
            event.ignore()
            return
        self._disconnect_fpga()
        super().closeEvent(event)

    # ------------------------------------------------------------------
    # Verilator helpers (unchanged logic)
    # ------------------------------------------------------------------

    def _cache_build_dir_for_verilog(self, verilog_path: Path) -> Path:
        cache_name = f"{verilog_path.stem}_{self.top_module_name}"
        return self.verilated_cache_root / cache_name

    def _expected_cached_lib_path(self, build_dir: Path) -> Path:
        # PyVerilator builds a loadable shared object named like V<top_module>.
        return build_dir / f"V{self.top_module_name}"

    def _cleanup_verilator_load_thread(self) -> None:
        if self.verilator_load_worker is not None:
            self.verilator_load_worker.deleteLater()
            self.verilator_load_worker = None
        if self.verilator_load_thread is not None:
            self.verilator_load_thread.quit()
            self.verilator_load_thread.wait()
            self.verilator_load_thread.deleteLater()
            self.verilator_load_thread = None

    def _on_async_verilator_load_finished(self, sim, loaded_ref: str, load_mode: str) -> None:
        self.sim = sim
        if load_mode in ("compiled", "cached"):
            self.verilog_path = Path(loaded_ref)

        if load_mode == "compiled":
            print(f"Loaded Verilog model (fresh compile): {loaded_ref}")
            self.set_verilog_status("Done (compiled)", "green")
        elif load_mode == "cached":
            print(f"Loaded Verilog model (cache hit): {loaded_ref}")
            self.set_verilog_status("Done (cache hit)", "green")
        else:
            print(f"Loaded prebuilt shared library: {loaded_ref}")
            self.set_verilog_status("Done (prebuilt)", "green")

        self.set_verilog_controls_enabled(True)
        self.on_verilator_source_mode_changed()
        self._cleanup_verilator_load_thread()

    def _on_async_verilator_load_failed(self, error_text: str) -> None:
        self.sim = self._previous_sim_before_load
        self.verilog_path = self._previous_path_before_load
        if self.verilog_path_input is not None and self._previous_path_before_load is not None:
            self.verilog_path_input.setText(str(self._previous_path_before_load))

        self.set_verilog_status("Compile/load failed", "red")
        if self._pending_prebuilt_mode:
            QMessageBox.critical(self, "Load Error", f"Failed to load shared library:\n{error_text}")
        else:
            QMessageBox.critical(self, "Load Error", f"Failed to load Verilog model:\n{error_text}")

        self.set_verilog_controls_enabled(True)
        self.on_verilator_source_mode_changed()
        self._cleanup_verilator_load_thread()

    def on_verilator_source_mode_changed(self) -> None:
        use_prebuilt = self.chk_use_prebuilt_so is not None and self.chk_use_prebuilt_so.isChecked()
        if self.verilog_path_input is not None:
            self.verilog_path_input.setEnabled(not use_prebuilt)
        if self.btn_browse_verilog is not None:
            self.btn_browse_verilog.setEnabled(not use_prebuilt)
        if self.prebuilt_so_path_input is not None:
            self.prebuilt_so_path_input.setEnabled(use_prebuilt)
        if self.btn_browse_prebuilt_so is not None:
            self.btn_browse_prebuilt_so.setEnabled(use_prebuilt)

    def load_simulator(self, verilog_path=None, so_path=None):
        if so_path is not None:
            resolved_so_path = Path(so_path).expanduser().resolve()
            self.sim = pyverilator.PyVerilator(str(resolved_so_path), auto_eval=True)
            return

        verilog_path = Path(verilog_path).expanduser().resolve()
        build_dir = self._cache_build_dir_for_verilog(verilog_path)
        build_dir.mkdir(parents=True, exist_ok=True)
        cached_lib = self._expected_cached_lib_path(build_dir)

        should_rebuild = True
        if cached_lib.exists():
            try:
                should_rebuild = cached_lib.stat().st_mtime < verilog_path.stat().st_mtime
            except OSError:
                should_rebuild = True

        if should_rebuild:
            self.sim = pyverilator.PyVerilator.build(
                str(verilog_path),
                top_module_name=self.top_module_name,
                build_dir=str(build_dir),
            )
        else:
            self.sim = pyverilator.PyVerilator(str(cached_lib), auto_eval=True)

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
        if self.chk_use_prebuilt_so is not None:
            self.chk_use_prebuilt_so.setEnabled(enabled)
        if self.prebuilt_so_path_input is not None:
            self.prebuilt_so_path_input.setEnabled(enabled and self.chk_use_prebuilt_so.isChecked())
        if self.btn_browse_prebuilt_so is not None:
            self.btn_browse_prebuilt_so.setEnabled(enabled and self.chk_use_prebuilt_so.isChecked())

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

    def on_browse_prebuilt_so(self):
        start_dir = str(self.verilated_cache_root if self.verilated_cache_root.exists() else self.verilog_path.parent)
        selected, _ = QFileDialog.getOpenFileName(
            self,
            "Select Prebuilt Verilator sim object",
            start_dir,
            "All Files (*)",
        )
        if selected:
            self.prebuilt_so_path_input.setText(selected)
            self.on_apply_verilog_path()

    def on_apply_verilog_path(self):
        if self.verilator_load_thread is not None and self.verilator_load_thread.isRunning():
            QMessageBox.information(self, "Busy", "Verilator compile/load is already in progress.")
            return

        use_prebuilt = self.chk_use_prebuilt_so.isChecked()

        if use_prebuilt:
            so_path = Path(self.prebuilt_so_path_input.text().strip())
            if not so_path.exists():
                self.set_verilog_status("Shared library not found", "red")
                QMessageBox.warning(self, "Invalid Path", f"Shared library not found:\n{so_path}")
                return
        else:
            candidate_path = Path(self.verilog_path_input.text().strip())
            if not candidate_path.exists():
                self.set_verilog_status("File not found", "red")
                QMessageBox.warning(self, "Invalid Path", f"Verilog file not found:\n{candidate_path}")
                return

        self._previous_sim_before_load = self.sim
        self._previous_path_before_load = self.verilog_path
        self._pending_prebuilt_mode = use_prebuilt
        self.set_verilog_controls_enabled(False)
        if use_prebuilt:
            self.set_verilog_status("Loading prebuilt shared library in background...", "orange")
        else:
            self.set_verilog_status(f"Building/loading cache in {self.verilated_cache_root} (background)...", "orange")
        QApplication.processEvents()

        worker_kwargs = {
            "use_prebuilt_so": use_prebuilt,
            "so_path": str(so_path) if use_prebuilt else None,
            "verilog_path": None if use_prebuilt else str(candidate_path),
            "build_dir": None if use_prebuilt else str(self._cache_build_dir_for_verilog(candidate_path)),
            "top_module_name": self.top_module_name,
        }

        self.verilator_load_thread = QThread(self)
        self.verilator_load_worker = VerilatorLoadWorker(**worker_kwargs)
        self.verilator_load_worker.moveToThread(self.verilator_load_thread)
        self.verilator_load_thread.started.connect(self.verilator_load_worker.run)
        self.verilator_load_worker.finished.connect(self._on_async_verilator_load_finished)
        self.verilator_load_worker.failed.connect(self._on_async_verilator_load_failed)
        self.verilator_load_worker.finished.connect(self.verilator_load_thread.quit)
        self.verilator_load_worker.failed.connect(self.verilator_load_thread.quit)
        self.verilator_load_thread.start()

    def on_clear_canvas(self):
        self.drawing_widget.clear()
        self._reset_plot_values()
        self.inference_status_label.setText("Canvas cleared")
        self.inference_status_label.setStyleSheet("color: gray;")

    def _reset_plot_values(self):
        for bar in self.bars:
            bar.set_width(0.0)
        self.canvas.draw()

    def _downsample_window_to_28(self, window_2d):
        src_h, src_w = window_2d.shape
        y_idx = np.linspace(0, src_h - 1, 28).astype(np.int32)
        x_idx = np.linspace(0, src_w - 1, 28).astype(np.int32)
        resized = window_2d[np.ix_(y_idx, x_idx)]
        return resized[np.newaxis, np.newaxis, :, :].astype(np.float32)

    def _find_connected_component_bboxes(self, mask_2d, min_pixels):
        height, width = mask_2d.shape
        visited = np.zeros((height, width), dtype=bool)
        bboxes = []

        for y in range(height):
            for x in range(width):
                if not mask_2d[y, x] or visited[y, x]:
                    continue

                stack = [(y, x)]
                visited[y, x] = True
                min_x = max_x = x
                min_y = max_y = y
                count = 0

                while stack:
                    cy, cx = stack.pop()
                    count += 1
                    min_x = min(min_x, cx)
                    max_x = max(max_x, cx)
                    min_y = min(min_y, cy)
                    max_y = max(max_y, cy)

                    neighbors = ((cy - 1, cx), (cy + 1, cx), (cy, cx - 1), (cy, cx + 1))
                    for ny, nx in neighbors:
                        if 0 <= ny < height and 0 <= nx < width and mask_2d[ny, nx] and not visited[ny, nx]:
                            visited[ny, nx] = True
                            stack.append((ny, nx))

                if count >= min_pixels:
                    bboxes.append((min_x, min_y, max_x + 1, max_y + 1, count))

        return bboxes

    def _expand_bbox_to_square(self, x0, y0, x1, y1, max_w, max_h):
        w = x1 - x0
        h = y1 - y0
        side = max(w, h)
        cx = (x0 + x1) // 2
        cy = (y0 + y1) // 2
        half = side // 2

        nx0 = cx - half
        ny0 = cy - half
        nx1 = nx0 + side
        ny1 = ny0 + side

        if nx0 < 0:
            nx1 -= nx0
            nx0 = 0
        if ny0 < 0:
            ny1 -= ny0
            ny0 = 0
        if nx1 > max_w:
            shift = nx1 - max_w
            nx0 -= shift
            nx1 = max_w
        if ny1 > max_h:
            shift = ny1 - max_h
            ny0 -= shift
            ny1 = max_h

        nx0 = max(0, nx0)
        ny0 = max(0, ny0)
        nx1 = min(max_w, nx1)
        ny1 = min(max_h, ny1)
        if nx1 <= nx0:
            nx1 = min(max_w, nx0 + 1)
        if ny1 <= ny0:
            ny1 = min(max_h, ny0 + 1)
        return nx0, ny0, nx1, ny1

    def _boxes_close_or_overlapping(self, a, b, merge_gap):
        ax0, ay0, ax1, ay1, _ = a
        bx0, by0, bx1, by1, _ = b

        # Inflate each rectangle by merge_gap and test for overlap.
        ax0 -= merge_gap
        ay0 -= merge_gap
        ax1 += merge_gap
        ay1 += merge_gap

        bx0 -= merge_gap
        by0 -= merge_gap
        bx1 += merge_gap
        by1 += merge_gap

        return not (ax1 < bx0 or bx1 < ax0 or ay1 < by0 or by1 < ay0)

    def _merge_nearby_bboxes(self, bboxes, merge_gap):
        if not bboxes:
            return []

        remaining = [list(box) for box in bboxes]
        merged = []

        while remaining:
            cur = remaining.pop()
            changed = True

            while changed:
                changed = False
                next_remaining = []
                for other in remaining:
                    if self._boxes_close_or_overlapping(cur, other, merge_gap):
                        cur[0] = min(cur[0], other[0])
                        cur[1] = min(cur[1], other[1])
                        cur[2] = max(cur[2], other[2])
                        cur[3] = max(cur[3], other[3])
                        cur[4] += other[4]
                        changed = True
                    else:
                        next_remaining.append(other)
                remaining = next_remaining

            merged.append(tuple(cur))

        return merged

    def _infer_logits(self, inp_value):
        if self.backend == 'verilator':
            if self.sim is None:
                raise RuntimeError("Verilator backend is not loaded. Load a model first.")
            self.sim.io.inp = inp_value
            return unpack_scores(int(self.sim.io.scores_flat))

        if self.fpga_uart is None or not self.fpga_uart.is_open():
            raise RuntimeError("FPGA backend is not connected.")

        scores_flat = self.fpga_uart.run_inference(inp_value)
        tx_bytes = self.fpga_uart.last_tx_bytes
        rx_bytes = self.fpga_uart.last_rx_bytes
        self._append_uart_console(f"[TX] {self._format_uart_bytes(tx_bytes)}")
        self._append_uart_console(f"[RX] {self._format_uart_bytes(rx_bytes)}")
        return unpack_scores(scores_flat)

    def _tighten_bbox_to_foreground(self, mask_2d, x0, y0, x1, y1):
        submask = mask_2d[y0:y1, x0:x1]
        ys, xs = np.where(submask)
        if xs.size == 0 or ys.size == 0:
            return None

        tx0 = int(x0 + xs.min())
        ty0 = int(y0 + ys.min())
        tx1 = int(x0 + xs.max() + 1)
        ty1 = int(y0 + ys.max() + 1)
        return tx0, ty0, tx1, ty1

    def on_run_bounding_box_inference(self):
        try:
            pixel_threshold = float(self.pixel_threshold_input.text().strip())
            min_pixels = int(self.min_pixels_input.text().strip())
            merge_gap = int(self.merge_gap_input.text().strip())
        except ValueError:
            QMessageBox.warning(self, "Invalid Parameters", "Pixel threshold must be numeric; min pixels and merge gap must be integers.")
            return

        if not (0.0 <= pixel_threshold <= 1.0):
            QMessageBox.warning(self, "Invalid Parameters", "Pixel threshold must be in [0.0, 1.0].")
            return
        if min_pixels <= 0:
            QMessageBox.warning(self, "Invalid Parameters", "Min pixels must be > 0.")
            return
        if merge_gap < 0:
            QMessageBox.warning(self, "Invalid Parameters", "Merge gap must be >= 0.")
            return

        self.inference_status_label.setText("Running bounding-box inference...")
        self.inference_status_label.setStyleSheet("color: orange;")
        QApplication.processEvents()

        full_img = self.drawing_widget.get_full_image_array()[0, 0]
        img_h, img_w = full_img.shape
        mask = full_img > pixel_threshold
        bboxes = self._find_connected_component_bboxes(mask, min_pixels=min_pixels)
        bboxes = self._merge_nearby_bboxes(bboxes, merge_gap=merge_gap)

        overlays = []
        class_counts = np.zeros(10, dtype=np.int32)
        num_boxes = 0

        try:
            for x0, y0, x1, y1, _ in bboxes:
                tightened = self._tighten_bbox_to_foreground(mask, x0, y0, x1, y1)
                if tightened is None:
                    continue

                tx0, ty0, tx1, ty1 = tightened
                sx0, sy0, sx1, sy1 = self._expand_bbox_to_square(tx0, ty0, tx1, ty1, img_w, img_h)
                patch = full_img[sy0:sy1, sx0:sx1]
                if patch.size == 0:
                    continue

                patch_28 = self._downsample_window_to_28(patch)
                inp_value = pack_binary_image_to_inp(patch_28)
                logits = self._infer_logits(inp_value)
                cls = int(np.argmax(logits))

                overlays.append((sx0, sy0, sx1 - sx0, sy1 - sy0, cls))
                class_counts[cls] += 1
                num_boxes += 1

            self.drawing_widget.set_overlay_windows(overlays)

            if num_boxes > 0:
                values = class_counts.astype(np.float32) / float(num_boxes)
            else:
                values = np.zeros(10, dtype=np.float32)

            for bar, val in zip(self.bars, values):
                bar.set_width(float(val))
            self.canvas.draw()

            self.inference_status_label.setText(f"Inference complete: {num_boxes} bounding boxes")
            self.inference_status_label.setStyleSheet("color: green;")
        except Exception as e:
            self.inference_status_label.setText(f"Inference failed: {e}")
            self.inference_status_label.setStyleSheet("color: red;")
            QMessageBox.critical(self, "Inference Error", str(e))

    def init_plot(self):
        self.ax.clear()
        self.bars = self.ax.barh(CLASSES, np.zeros(10), color=CLASS_COLORS_HEX)
        self.ax.set_xlim(0, 1)
        self.ax.set_xlabel('Box Fraction')
        self.ax.set_title('Bounding-Box Argmax Distribution')
        self.ax.invert_yaxis()  # to match the order in CLASSES from top to bottom
        self.figure.tight_layout()
        self.canvas.draw()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())
