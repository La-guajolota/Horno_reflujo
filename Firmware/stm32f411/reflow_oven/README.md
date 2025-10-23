# 🔥 Reflow Oven Firmware 🔥

This directory contains the main **STM32CubeIDE project** for the reflow oven. This firmware is the core of the oven's control system.

---

## 📂 Project Structure

- **Core/**: Contains the main application source code, including `main.c`, the state machine, and drivers for peripherals.
- **Drivers/**: STM32 HAL drivers and CMSIS.
- **.ioc**: The STM32CubeMX configuration file. You can open this file to view and edit the microcontroller's peripheral settings.
- **.cproject** and **.project**: Eclipse project files for STM32CubeIDE.

---

## 🚀 How to Use

1. **Open in STM32CubeIDE**: Import this directory as a project in the STM32CubeIDE.
2. **Configure Peripherals**: Double-click the `.ioc` file to open the STM32CubeMX perspective and configure the microcontroller's peripherals.
3. **Build & Flash**: Build the project and flash the firmware to your STM32F411 board.
4. **Debug**: Use the debugging tools in STM32CubeIDE to test and debug the firmware.
