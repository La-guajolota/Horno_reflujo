<!-- @format -->

# STM32F411 Reflow Oven Firmware

Welcome to the **STM32F411** section of the Reflow Oven Firmware project! This folder contains all the source code, libraries, and scripts required to implement precise control and monitoring of your reflow oven using the STM32F411 microcontroller.

---

## Folder Structure

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

## Project Organization

### **1. Core Application**

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
  `Core/Src/main.c` initializes hardware, configures peripherals, and starts the main control loop.

### **2. Hardware Abstraction & Drivers**

- **Drivers:**  
  Located in `Drivers/`, including STM32 HAL, CMSIS, and custom drivers for:

  - Thermocouple/temperature sensors (e.g., MAX6675, MAX31855)
  - Solid State Relay (SSR) control
  - UART/USART for serial communication
  - I2C/SPI for sensor and display interfaces

- **Peripheral Configuration:**  
  All hardware peripherals are configured via CubeMX (`CubeMX_Config/reflow_oven.ioc`).  
  Pin assignments, clock settings, and middleware are documented in `Docs/hardware_config.md`.

### **3. Control Algorithms**

- **PID Controller:**  
  Implemented in `Core/Src/pid.c` and `Core/Inc/pid.h` for precise temperature regulation.

- **Kalman Filtering:**  
  MATLAB/Octave scripts in `Kalman_filter_desing/` are used to design and analyze filters for sensor noise reduction.  
  Filter coefficients can be ported to C and integrated into the firmware.

### **4. Communication & Interfaces**

- **Serial Communication:**  
  UART routines for debugging and external control (e.g., ESP8266, PC) are in `Core/Src/serial.c`.

- **Display & HMI:**  
  Support for Nextion or other displays can be added via SPI/UART drivers.

### **5. Safety & Error Handling**

- **Error States:**  
  The FSM includes error detection for sensor faults, over-temperature, and hardware failures.  
  Error handling routines are in `Core/Src/error.c`.

- **Logging:**  
  Optional logging of temperature profiles and events via UART or external memory.

---

## Getting Started

1. **Open the Project:**

   - Use STM32CubeIDE to open `reflow_oven/`.
   - Review and modify CubeMX configuration as needed.

2. **Build & Flash:**

   - Build the project and flash to your STM32F411 board.

3. **Configure Hardware:**

   - Connect sensors, SSR, and display as per `Docs/hardware_config.md`.

4. **Test & Debug:**
   - Use serial debugging tools to monitor oven status and troubleshoot.

---

## To-Do List

- [ ] Refactor state machine for modularity and scalability
- [ ] Implement EEPROM/Flash storage for user profiles
- [ ] Integrate advanced safety checks (door open, power loss)
- [ ] Add PID auto-tuning
- [ ] Enhance documentation with flowcharts and timing diagrams
- [ ] Add unit tests for critical modules

---

## Contributing

Pull requests and suggestions are welcome! Please open an issue for bugs or feature requests.
