# 🌐 ESP01 Web GUI 🌐

<p align="center">
  <img src="../../../pictures/gui_reflow_main.png" alt="Web GUI Banner" width="600"/>
</p>

This directory contains the PlatformIO project for the **ESP-01S web-based GUI**. This firmware allows you to control and monitor the reflow oven wirelessly from any web browser.

---

## 📂 Project Structure

- **src/**: Contains the main source code (`main.cpp`).
- **include/**: Header files.
- **lib/**: Project-specific libraries.
- **platformio.ini**: PlatformIO project configuration file.

---

## 🚀 How to Use

1. **Open in PlatformIO**: Open this directory as a project in the PlatformIO IDE.
2. **Configure WiFi**: Edit the `src/main.cpp` file to set your WiFi credentials (SSID and password).
3. **Build & Upload**: Build the project and upload the firmware to your ESP-01S module.
4. **Connect**: Once uploaded, the ESP-01S will connect to your WiFi network and host the web server. You can access the GUI by navigating to the IP address of the ESP-01S in your web browser.
