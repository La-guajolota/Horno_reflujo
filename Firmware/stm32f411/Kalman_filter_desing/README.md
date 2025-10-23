# 📈 Kalman Filter Design 📈

This directory contains scripts for designing and analyzing a **Kalman filter** to reduce noise from the temperature sensors in the reflow oven.

---

## 📂 Files

- **FOPDT.m**: A MATLAB/Octave script for First-Order Plus Dead Time (FOPDT) modeling of the system.
- **Kalmanfilter0.py**: A Python script for designing and simulating the Kalman filter.
- **octave_analysis.m**: A MATLAB/Octave script for analyzing the filter's performance.
- **resultado_filtro_kalman.png**: An image showing the results of the Kalman filter analysis.

---

## 🚀 How to Use

1. **Run Scripts**: Use MATLAB, Octave, or Python to run the scripts and analyze the filter's behavior.
2. **Port to C**: The resulting filter coefficients can be ported to the main STM32 firmware to improve the accuracy of the temperature readings.
