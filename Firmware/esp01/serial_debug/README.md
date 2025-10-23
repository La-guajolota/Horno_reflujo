# 🐍 Serial Debug 🐍

This directory contains Python scripts for debugging the reflow oven's firmware via serial communication.

---

## 📂 Files

- **serialTest.py**: A script to test serial communication with the microcontroller. It sends commands and prints the responses.
- **serialUtils.py**: A collection of utility functions to handle serial data, such as parsing and formatting.

---

## 🚀 How to Use

1. **Install Dependencies**: Make sure you have Python 3 and the `pyserial` library installed:
   ```bash
   pip install pyserial
   ```
2. **Connect Hardware**: Connect the microcontroller to your computer via a USB-to-serial adapter.
3. **Run Scripts**: Run the `serialTest.py` script to start debugging:
   ```bash
   python serialTest.py
   ```
