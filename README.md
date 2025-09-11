<!-- @format -->

# 🔥 SMD Reflow Oven

This project provides an open-source design for soldering SMD components using reflow technology, featuring precise temperature control and integrated ventilation, optimized for PCBs up to 15x15 cm.

---

## 📑 Table of Contents

1. [Overview](#overview)
2. [Main Features](#main-features)
3. [Workflow](#workflow)
4. [Technical Challenges](#technical-challenges)
5. [Repository Structure](#repository-structure)
6. [Requirements & Dependencies](#requirements--dependencies)
7. [Installation & Usage](#installation--usage)
8. [Contributors](#contributors)
9. [License](#license)
10. [Images](#images)
11. [Reference Links](#reference-links)
12. [Possible Improvements](#possible-improvements)
13. [Considerations](#considerations)

---

## Overview

The SMD Reflow Oven enables:

- Soldering SMD components using solder paste and configurable thermal profiles.
- Processing PCBs up to 15x15 cm.
- Real-time temperature curve control to prevent defects.
- Management of toxic vapors with an integrated ventilation system.
- Intuitive interface with a touchscreen for operation and monitoring.

**Project Status:**
This is currently a simple but functional demo. Core features work, but the system is under active development and improvements are planned.

Modular and accessible design for rapid prototyping and adaptation to various production environments.

---

## ✨ Main Features

- Thermal control: Customizable profiles for different solder types.
- Uniform heating: Even heat distribution across the PCB surface.
- Safety: Emergency stop system for overheating.
- Graphical interface: Configurable menus and real-time temperature curve display on touchscreen.
- Comprehensive documentation: Flow diagrams, bill of materials, and calibration guides.

---

## 🔄 Workflow

1. PCB Preparation

   - Apply solder paste using stencil or dispenser.
   - Place SMD components with tweezers or Pick & Place machine.

2. Oven Setup

   - Select thermal profile according to solder type.
   - Preheat oven to stabilize temperatures.

3. Soldering Process

   - Insert PCB into oven.
   - Execute temperature curve:
     1. Preheat: Evaporate paste solvents (100-150°C).
     2. Soak: Equalize temperature across PCB (150-180°C).
     3. Reflow: Melt solder (peak 220-250°C).
     4. Controlled cooling: Reduce thermal stress (<100°C).

4. Final Inspection
   - Check joints with magnifier or microscope.
   - Perform electrical tests to detect shorts.
   - Manually correct defective solder joints.

---

## 🎯 Technical Challenges

1. Temperature control

   - Uniform distribution throughout oven chamber.
   - Adaptation to different thermal curves by material.
   - Prevent microcracks from rapid cooling.

2. Risk management

   - Automatic overheating detection (emergency stop).
   - Filtering toxic vapors during process.

3. Operational precision
   - Calibration of thermal sensors.
   - Synchronization between heating/cooling stages.

---

## 📂 Repository Structure

```text
.
├── Firmware/                  # Firmware for ESP01, STM32, serial debug, web scraping
│   ├── esp01/                 # ESP01 microcontroller code
│   │   ├── esp01_webGUI/      # Web GUI for ESP01
│   │   └── serial_debug/      # Serial communication utilities
│   └── web_scrap/             # Python scripts for oven data analysis
├── nextionGUI/                # Touchscreen HMI files and assets
├── stm32f411/                 # STM32F411 microcontroller code and Kalman filter design
├── Hardware/                  # KiCad PCB and schematic files
│   ├── horno_no_modificado/   # Original oven hardware
│   └── horno_reflujo/         # Reflow oven hardware, BOM, backups
├── imagenes/                  # Images and diagrams
├── LICENSE                    # MIT License
└── README.md                  # Main project guide
```

---

## 🖼️ Images

Add images here to illustrate hardware, GUI, workflow, etc. Example:

![Oven Front Panel](imagenes/placaFront.pdf)
![PCB Example](Hardware/horno_reflujo/horno_reflujo.kicad_pcb)

---

## 🔗 Reference Links

- [PlatformIO Documentation](https://docs.platformio.org/)
- [KiCad EDA](https://www.kicad.org/)
- [STM32 Documentation](https://www.st.com/en/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus.html)
- [Nextion HMI](https://nextion.tech/)
- [Python Serial](https://pyserial.readthedocs.io/en/latest/)

---

## 🚀 Possible Improvements

- Add WiFi connectivity for remote monitoring and control
- Implement advanced PID or machine learning temperature control
- Expand touchscreen GUI features
- Add automated solder paste dispenser
- Improve ventilation and vapor filtering system
- Integrate oven calibration routines

---

## ⚠️ Considerations

- Ensure proper ventilation when operating the oven
- Use protective equipment when handling solder paste and PCBs
- Regularly calibrate temperature sensors for accuracy
- Backup hardware and firmware files before making changes
- Review electrical safety guidelines for high-voltage components

---

## 📦 Requirements & Dependencies

- PlatformIO for firmware development
- Python 3.x for data analysis scripts
- KiCad for hardware design
- Nextion Editor for HMI design
- STM32CubeIDE for STM32 development

---

## 🛠️ Installation & Usage

1. Clone the repository:
   ```sh
   git clone https://github.com/La-guajolota/Horno_reflujo.git
   ```
2. Follow instructions in each subfolder's README for setup and usage.
3. Refer to documentation for hardware assembly and calibration.

---

## 👥 Contributors

- [La-guajolota](https://github.com/La-guajolota)
- [tonyg982](https://github.com/tonyg982)

---

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.
