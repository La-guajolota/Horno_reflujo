<!-- @format -->

# Reflow Oven Firmware

This directory contains the firmware and software utilities for the reflow oven project. Here you will find the files and documentation needed for development, testing, and communication with the system's electronic modules.

## Project Structure

- **esp01/**: Code and resources for the ESP01 microcontroller.
  - **esp01_webGUI/**: PlatformIO project for ESP01 with web interface.
  - **serial_debug/**: Python scripts for debugging and serial communication.
    - `serialTest.py`: Serial communication tests.
    - `serialUtils.py`: Utilities for handling serial data.
  - **web_scrap/**: Tools for data analysis and web scraping.
    - `fopdt.py`, `stepResponse.py`: System response modeling and analysis.
    - `regresion_horno.xlsx`, `regresion_horno2.xlsx`: Regression data and analysis.
    - `web_client.py`: Web client for interaction and testing.

## Features

- PlatformIO projects ready for ESP01 microcontrollers.
- Python scripts for debugging and serial communication.
- Tools for data analysis and thermal system modeling.
- Documentation and examples to facilitate development and testing.

## Getting Started

1. **Clone the repository**
   ```sh
   git clone <repo-url>
   ```
2. **Explore the subdirectories**
   - Open the PlatformIO projects in `esp01_webGUI/` for ESP01 development.
   - Use the Python scripts in `serial_debug/` and `web_scrap/` for testing and analysis.
3. **Check the documentation**
   - Review the README files and scripts for specific usage instructions.

## TODO

- [ ] Add detailed assembly instructions for the oven hardware
- [ ] Include safety guidelines and troubleshooting tips
- [ ] Translate documentation to English

## Contact

For questions or contributions, please open an issue or contact the project maintainer.
