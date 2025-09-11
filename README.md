<!-- @format -->

# 🔥 SMD Reflow Oven

<p align="center">
  <img src="imagenes/logo.jpeg" alt="Project Logo" width="180" />
</p>

<p align="center">
  <b>Open-source hardware & firmware for SMD soldering with reflow technology</b><br>
  Modular, accessible, and designed for rapid prototyping and production.
</p>

---

## 📑 Table of Contents

1. [Overview](#-overview)
2. [Workflow](#-workflow)
3. [Technical Challenges](#-technical-challenges)
4. [Repository Structure](#-repository-structure)
5. [Requirements & Dependencies](#-requirements--dependencies)
6. [Installation & Usage](#-installation--usage)
7. [Images](#-images)
8. [Reference Links](#-reference-links)
9. [Possible Improvements](#-possible-improvements)
10. [To-Do & Contributions](#-to-do--contributions)
11. [Considerations](#-considerations)
12. [Contributors](#-contributors)
13. [License](#-license)

---

## 📝 Overview

The **SMD Reflow Oven** enables:

- Soldering SMD components using solder paste and configurable thermal profiles, managed by an **STM32F411** and an **ESP01-S1 web GUI**.
- Real-time temperature curve control with PID feedback to prevent defects.
- Power control for heating elements and fan for chamber homogenization.
- Safety features: sensor malfunction detection, process monitoring, power supply fuse, and EMI filter.

> **Project Status:**  
> Functional demo: all core features (PID, temperature sensing, web GUI, reflow algorithm) are working.  
> The project is under active development for both firmware and hardware improvements.

---

## 🔄 Workflow

<details>
<summary><b>Step-by-step SMD soldering process</b></summary>

1. **PCB Preparation**

   - Apply solder paste using a stencil (can be 3D printed).
   - Place SMD components.

2. **Oven Setup**

   - Power the oven (120V AC).
   - Select thermal profile and PID gains via web GUI or source code.

3. **Soldering Process**

   - Insert PCB into oven.
   - Press **Start Process** button.

4. **Final Inspection**
   - At the CoolDown state, open oven door completely.
   - Wait for cooldown.
   - Inspect joints with magnifier/microscope.
   - Run electrical tests and correct defects if needed.

</details>

---

## 🎯 Technical Challenges

- **Temperature Control:** Uniform distribution, adaptable thermal curves, prevent microcracks.
- **Risk Management:** Overheating detection, toxic vapor filtering.
- **Operational Precision:** Sensor calibration, stage synchronization.

---

## 📂 Repository Structure

```text
.
├── Firmware/                  # Firmware for ESP01, STM32, serial debug, web scraping
│   ├── esp01/                 # ESP01 microcontroller code
│       ├── esp01_webGUI/      # Web GUI for ESP01
│       ├── serial_debug/      # Serial communication utilities
│       └── web_scrap/             # Python scripts for oven data analysis
├── nextionGUI/                # Touchscreen HMI files and assets
├── stm32f411/                 # STM32F411 microcontroller code and Kalman filter design
├── Hardware/                  # KiCad PCB and schematic files
│   ├── horno_no_modificado/   # Original oven hardware
│   └── horno_reflujo/         # Reflow oven hardware, BOM, backups
├── imagenes/                  # Images and diagrams
├── LICENSE                    # MIT License
└── README.md                  # Main project guide
```
