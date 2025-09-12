<!-- @format -->

# STM32F411 Reflow Oven Firmware

Welcome to the **STM32F411** section of the Reflow Oven Firmware project! Here you'll find everything needed for precise control and monitoring of your reflow oven using the STM32F411 microcontroller.

<br>
<div align="center">
  <img src="https://img.shields.io/badge/Platform-STM32F411-blue" alt="Platform" />
  <img src="https://img.shields.io/badge/Language-C%20%7C%20C%2B%2B-brightgreen" alt="Language" />
  <img src="https://img.shields.io/badge/Display-OLED%20%7C%20Nextion-yellow" alt="Display" />
</div>

---

---

## 🧩 Firmware Architecture & Module Overview

<div align="center">
  <img src="https://img.icons8.com/fluency/96/000000/microchip.png" alt="Microcontroller" width="64"/>
</div>

The firmware is modular, with each main function separated into dedicated folders and files for clarity and scalability. Explore the main modules below:

<details open>
<summary><strong>🖥️ User Interface (UI)</strong></summary>

<ul>
<li><code>Core/Inc/UI/</code> & <code>Core/Src/UI/</code></li>
<li><code>gui_backend.h/c</code>: Backend logic for the oven's graphical user interface</li>
<li><code>screen/ssd1306.h/c</code>: OLED display driver and configuration</li>
</ul>
<span style="color:#4CAF50"><strong>Functionality:</strong></span> Manages the OLED display, presents real-time oven status, temperature, and process info. Handles user inputs and updates the GUI state machine.

</details>

<details open>
<summary><strong>⚙️ Logic Control</strong></summary>

<ul>
<li><code>Core/Inc/logic_control/</code> & <code>Core/Src/logic_control/</code></li>
<li><code>pid.h/c</code>: PID controller implementation</li>
<li><code>reflow_oven_process.h/c</code>: State machine and process logic</li>
</ul>
<span style="color:#4CAF50"><strong>Functionality:</strong></span> Governs oven operation, executes the reflow profile, manages transitions, and applies PID control to heating elements.

</details>

<details open>
<summary><strong>🌡️ Sensors</strong></summary>

<ul>
<li><code>Core/Inc/sensors/</code> & <code>Core/Src/sensors/</code></li>
<li><code>max6675.h/c</code>: Thermocouple sensor driver</li>
<li><code>digital_filter.h/c</code>: Digital filtering algorithms (EMA, Moving Average)</li>
</ul>
<span style="color:#4CAF50"><strong>Functionality:</strong></span> Reads temperature data, applies filtering, and provides reliable input for control logic and PID.

</details>

<details open>
<summary><strong>🔄 Main Application</strong></summary>

<ul>
<li><code>Core/Src/main.c</code></li>
</ul>
<span style="color:#4CAF50"><strong>Functionality:</strong></span> Initializes all modules, coordinates UI, logic control, and sensors. Handles timer interrupts, user inputs, display updates, and communication with external devices (e.g., ESP01 web server).

</details>

---

---

---

## 📁 Folder Structure

```
stm32f411/
├── Kalman_filter_desing/   # MATLAB/Octave scripts for sensor filtering and analysis
└── reflow_oven/            # Main STM32 firmware (CubeMX project)
    └── Core/               # Application source code (main, state machine, drivers)
        ├── Inc/                # Header files for application and hardware abstraction
        ├── Src/                # Source files for application logic and hardware interfaces
    ├── CubeMX_Config/      # CubeMX configuration files (.ioc, .xml)
```

---

## 🏗️ Project Organization

### 1️⃣ Core Application

- **State Machine:**  
  The oven control logic is implemented as a finite state machine (FSM) in `Core/Src/state_machine.c` and `Core/Inc/state_machine.h`.  
  States include:

  - Idle
  - Preheat
  - Soak
  - Reflow
  - Cooldown
  - Error/Abort  
    Transitions are triggered by temperature readings, timer events, and user commands.

- **Main Entry Point:**  
  `Core/Src/main.c` ties together all modules, managing PID temperature control, sensor readings, actuator updates, and user interface logic. The oven process is operated through a combination of timer-driven events and user commands, with safety checks and feedback provided via display and web server.

### 2️⃣ Hardware Abstraction & Drivers

- **Drivers:**  
  Located in `Drivers/`, including STM32 HAL, CMSIS, and custom drivers for:

  - Thermocouple/temperature sensors (e.g., MAX6675, MAX31855)
  - Solid State Relay (SSR) control
  - UART/USART for serial communication
  - I2C/SPI for sensor and display interfaces

- **Peripheral Configuration:**  
  All hardware peripherals are configured via CubeMX (`CubeMX_Config/reflow_oven.ioc`).  
  Pin assignments, clock settings, and middleware are documented in `Docs/hardware_config.md`.

### 3️⃣ Control Algorithms

- **PID Controller:**  
  Implemented in `Core/Src/pid.c` and `Core/Inc/pid.h` for precise temperature regulation.

- **Kalman Filtering:**  
  MATLAB/Octave scripts in `Kalman_filter_desing/` are used to design and analyze filters for sensor noise reduction.  
  Filter coefficients can be ported to C and integrated into the firmware.

### 4️⃣ Communication & Interfaces

- **Serial Communication:**  
  UART routines for debugging and external control (e.g., ESP8266, PC) are in `Core/Src/serial.c`.

- **Display & HMI:**  
  Support for Nextion or other displays can be added via SPI/UART drivers.

### 5️⃣ Safety & Error Handling

- **Error States:**  
  The FSM includes error detection for sensor faults, over-temperature, and hardware failures.  
  Error handling routines are in `Core/Src/error.c`.

- **Logging:**  
  Optional logging of temperature profiles and events via UART or external memory.

---

---

## � Missing Features & Areas for Improvement

- Refactor the state machine for better modularity and scalability
- Implement EEPROM/Flash storage for user profiles and oven settings
- Add advanced safety checks (door open detection, power loss handling)
- Integrate PID auto-tuning for easier calibration
- Add unit tests for critical modules (PID, sensor drivers, FSM)
- Expand documentation with flowcharts, timing diagrams, and hardware connection guides

---

---

## 🚀 Quick Start

<ol>
  <li><strong>Open the Project:</strong><br>
    Use STM32CubeIDE to open <code>reflow_oven/</code>.<br>
    Review and modify CubeMX configuration as needed.
  </li>
  <li><strong>Build & Flash:</strong><br>
    Build the project and flash to your STM32F411 board.
  </li>
  <li><strong>Configure Hardware:</strong><br>
    Connect sensors, SSR, and display as per <code>Docs/hardware_config.md</code>.
  </li>
  <li><strong>Test & Debug:</strong><br>
    Use serial debugging tools to monitor oven status and troubleshoot.
  </li>
</ol>

---

## 📋 To-Do List

- [ ] Refactor state machine for modularity and scalability
- [ ] Implement EEPROM/Flash storage for user profiles
- [ ] Integrate advanced safety checks (door open, power loss)
- [ ] Add PID auto-tuning
- [ ] Enhance documentation with flowcharts and timing diagrams
- [ ] Add unit tests for critical modules

---

## 🤝 Contributing

Pull requests and suggestions are welcome! Please open an issue for bugs or feature requests.
