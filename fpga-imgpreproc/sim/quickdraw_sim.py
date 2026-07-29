#!/usr/bin/env python3
"""
QuickDraw FPGA Simulator - Main entry point
Start the PyQt6 GUI for FPGA simulation
"""

import sys
import os
from pathlib import Path

# Ensure we can import from the fpga-imgpreproc directory
sys.path.insert(0, str(Path(__file__).parent))

def main():
    """Main entry point"""
    try:
        from quickdraw_gui import QApplication, QuickDrawSimulator
        
        app = QApplication(sys.argv)
        window = QuickDrawSimulator()
        window.show()
        sys.exit(app.exec())
    
    except ImportError as e:
        print(f"ERROR: Missing dependency: {e}")
        print("\nPlease install required packages:")
        print("  pip install -r requirements.txt")
        sys.exit(1)
    except Exception as e:
        print(f"ERROR: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
