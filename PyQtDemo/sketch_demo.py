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
from PyQt6.QtCore import Qt, QPoint, QTimer, QObject, QThread, pyqtSignal

import matplotlib.pyplot as plt
from matplotlib.backends.backend_qtagg import FigureCanvasQTAgg as FigureCanvas

DEFAULT_CLASSES = [
    "airplane",
    "apple",
    "bicycle",
    "book",
    "car",
    "cell_phone",
    "eye",
    "eyeglasses",
    "smiley_face",
    "tree",
]


def load_class_names() -> list[str]:
    return DEFAULT_CLASSES


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
        #raw = (scores_flat >> (6 * i)) & 0x0000003f
        raw = (scores_flat >> (32 * i)) & 0xffffffff
        scores.append(to_signed32(raw))
    ret = np.array(scores, dtype=np.float32)
    return ret


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
        self.chk_use_prebuilt_so = None
        self.prebuilt_so_path_label = None
        self.prebuilt_so_path_input = None
        self.btn_browse_prebuilt_so = None
        self.verilator_load_thread = None
        self.verilator_load_worker = None
        self._previous_sim_before_load = None
        self._previous_path_before_load = None
        self._pending_prebuilt_mode = False

        # Inference backend state
        self.backend = 'verilator'   # 'verilator' | 'fpga'
        self.fpga_uart = None        # FPGAUARTInference instance (or None)

        # Build and load the default Verilog model using pyverilator.
        project_root = Path(__file__).resolve().parents[1]
        self.verilog_path = project_root / "verilog" / "mlp_quickdraw_4k_4k.v"
        self.verilated_cache_root = project_root / "verilated"
        self.top_module_name = "circuit"
        neuralut_root = project_root.parent / "NeuraLUT"
        self.classes = load_class_names()
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

        self.drawing_widget = DrawingWidget(self.on_draw_update)
        left_layout.addWidget(self.drawing_widget)
        
        self.btn_clear = QPushButton("Clear Canvas")
        self.btn_clear.clicked.connect(self.drawing_widget.clear)
        left_layout.addWidget(self.btn_clear)

        self.chk_softmax = QCheckBox("Apply Softmax")
        self.chk_softmax.setChecked(True)
        self.chk_softmax.stateChanged.connect(self.on_softmax_toggled)
        left_layout.addWidget(self.chk_softmax)

        ascii_group = QGroupBox("ASCII Bitmap Input (28x28)")
        ascii_layout = QVBoxLayout()
        ascii_group.setLayout(ascii_layout)

        self.ascii_bitmap_input = QPlainTextEdit()
        self.ascii_bitmap_input.setPlaceholderText(
            "Paste 28 lines of 28 chars each, using only 0 and 1"
        )
        self.ascii_bitmap_input.setFixedHeight(180)
        ascii_layout.addWidget(self.ascii_bitmap_input)

        self.btn_run_ascii_bitmap = QPushButton("Run ASCII Bitmap")
        self.btn_run_ascii_bitmap.clicked.connect(self.on_run_ascii_bitmap)
        ascii_layout.addWidget(self.btn_run_ascii_bitmap)

        left_layout.addWidget(ascii_group)
        left_layout.addStretch()
        
        layout.addLayout(left_layout)
        
        # Right side layout (Matplotlib)
        self.figure, self.ax = plt.subplots(figsize=(6, 4))
        self.canvas = FigureCanvas(self.figure)
        layout.addWidget(self.canvas)
        
        self.init_plot()
        self.on_verilator_source_mode_changed()
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

    def on_softmax_toggled(self):
        self.on_draw_update(self.drawing_widget.get_image_array())

    def parse_ascii_bitmap(self, text: str) -> np.ndarray:
        lines = [line.strip() for line in text.strip().splitlines() if line.strip()]
        if len(lines) != 28:
            raise ValueError(f"Expected 28 non-empty rows, got {len(lines)}")

        bitmap = np.zeros((28, 28), dtype=np.float32)
        for row_idx, line in enumerate(lines):
            if len(line) != 28:
                raise ValueError(
                    f"Row {row_idx + 1} must contain exactly 28 characters, got {len(line)}"
                )
            for col_idx, ch in enumerate(line):
                if ch not in ("0", "1"):
                    raise ValueError(
                        f"Invalid character '{ch}' at row {row_idx + 1}, col {col_idx + 1}; only 0/1 are allowed"
                    )
                bitmap[row_idx, col_idx] = 1.0 if ch == "1" else 0.0

        return np.expand_dims(bitmap, axis=(0, 1))

    def on_run_ascii_bitmap(self):
        try:
            img_array = self.parse_ascii_bitmap(self.ascii_bitmap_input.toPlainText())
        except ValueError as e:
            QMessageBox.warning(self, "Invalid ASCII Bitmap", str(e))
            return

        self.on_draw_update(img_array)

    def init_plot(self):
        self.ax.clear()
        self.bars = self.ax.barh(self.classes, np.zeros(10), color='skyblue')
        self.ax.set_xlim(0, 1)
        self.ax.set_xlabel('Probability')
        self.ax.set_title('Live Prediction')
        self.ax.invert_yaxis()  # top-to-bottom matches class index order
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
                    #self.sim.io.rst = 0
                    #self.sim.io.clk = 0
                    #self.sim.io.rst = 1
                    #for i in range(10):
                    #    self.sim.io.clk = 1
                    #    self.sim.io.clk = 0
                    #self.sim.io.rst = 0
                    self.sim.io.inp = inp_value
                    #for i in range(10):
                    #    self.sim.io.clk = 1
                    #    self.sim.io.clk = 0
                    self.sim.eval()
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
