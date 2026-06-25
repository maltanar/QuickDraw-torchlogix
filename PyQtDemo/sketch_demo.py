import sys
import numpy as np
from pathlib import Path
import pyverilator
from PyQt6.QtWidgets import (
    QApplication,
    QFileDialog,
    QHBoxLayout,
    QLabel,
    QLineEdit,
    QMainWindow,
    QMessageBox,
    QPushButton,
    QVBoxLayout,
    QWidget,
)
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
        self.verilog_path_input = None
        self.btn_browse_verilog = None
        self.btn_load_verilog = None

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

        path_row = QHBoxLayout()
        path_row.addWidget(QLabel("Verilog:"))
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
        left_layout.addStretch()
        
        layout.addLayout(left_layout)
        
        # Right side layout (Matplotlib)
        self.figure, self.ax = plt.subplots(figsize=(6, 4))
        self.canvas = FigureCanvas(self.figure)
        layout.addWidget(self.canvas)
        
        self.init_plot()
        self.drawing_widget.clear() # trigger initial plot 

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
        try:
            if self.sim is None:
                probs = np.zeros(10)
            else:
                inp_value = pack_binary_image_to_inp(img_array)
                self.sim.io.inp = inp_value
                logits = unpack_scores(int(self.sim.io.scores_flat))

                # Apply Softmax to get probabilities.
                exp_logits = np.exp(logits - np.max(logits))
                probs = exp_logits / exp_logits.sum()
        except Exception as e:
            print(f"Inference error: {e}")
            probs = np.zeros(10)
            
        # Update plot bars
        for bar, prob in zip(self.bars, probs):
            bar.set_width(prob)
        self.canvas.draw()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())
