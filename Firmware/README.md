<!-- @format -->

# Reflow Oven Firmware

This folder contains all the code, scripts, and resources needed to control and monitor a reflow oven using STM32 and ESP8266 microcontrollers, with web and hardware interfaces.

## Folder Structure

```
.
├── esp01/
│   ├── esp01_webGUI/      # ESP8266 Web GUI firmware (PlatformIO project)
│   ├── serial_debug/      # Python scripts for serial debugging and communication
│   └── web_scrap/         # Data analysis and web client scripts
├── nextionGUI/            # Nextion HMI GUI files and assets
├── stm32f411/
│   ├── Kalman_filter_desing/ # MATLAB/Octave scripts for sensor filtering
│   └── reflow_oven/          # STM32 reflow oven firmware (CubeMX project)
```

## Project Overview

This session is organized into several main components:

- **esp01/esp01_webGUI/**: Source code for the ESP8266-based web interface, allowing users to control and monitor the oven remotely. Built with PlatformIO and Arduino framework.
- **esp01/serial_debug/**: Python utilities for debugging and communicating with the oven controller via serial port.
- **esp01/web_scrap/**: Scripts for data analysis, regression, and client logging, including Excel files for thermal profile analysis.
- **nextionGUI/**: GUI files for the Nextion touchscreen display, including HMI project and assets.
- **stm32f411/reflow_oven/**: Main firmware for the STM32F411 microcontroller, implementing oven control logic, PID, and hardware interfaces.
- **stm32f411/Kalman_filter_desing/**: Scripts for designing and analyzing Kalman filters for sensor data.

## Getting Started

1. **STM32 Firmware**:

   - Open `stm32f411/reflow_oven/` with STM32CubeIDE.
   - Build and flash to your STM32F411 board.

2. **ESP8266 Web GUI**:

   - Open `esp01/esp01_webGUI/` with PlatformIO.
   - Configure WiFi credentials in `configs.hpp`.
   - Build and upload to your ESP01 module.

3. **Serial Debugging**:

   - Use the Python scripts in `esp01/serial_debug/` to communicate with the oven via USB serial.

4. **Data Analysis**:
   - Run Octave/MATLAB scripts in `stm32f411/Kalman_filter_desing/` for sensor and thermal profile analysis.
   - Use Excel files and Python scripts in `esp01/web_scrap/` for regression and step response analysis.

## Contributing

Feel free to open issues or submit pull requests for improvements, bug fixes, or new features!
