# 🛠️ Hardware 🛠️

<p align="center">
  <img src="../pictures/montada.jpg" alt="Hardware Banner" width="600"/>
</p>

This directory contains all the hardware design files for the **SMD Reflow Oven** project. This includes KiCad project files, schematics, PCB layouts, and other related resources.

---

## 📂 Folder Structure

- **horno_no_modificado/**: Contains the original, unmodified schematic files for the oven.
- **horno_reflujo/**: The main KiCad project for the custom reflow oven hardware. This includes:
  -  schematics (`.kicad_sch`)
  - PCB layout (`.kicad_pcb`)
  - Bill of Materials (BOM)
  - Production files for manufacturing.
- **imagenes/**: Reference images and diagrams.

---

## 🚀 Getting Started

To work with the hardware files, you will need:

- **KiCad**: To open and edit the schematic and PCB layout files.

Each subdirectory contains a more detailed `README.md` file with specific instructions on how to use its contents.

---

## 📝 PCB Design Notes & Improvements

While the current electronics are functional, several improvements have been identified for future revisions of the PCB:

- **Component Sizing**: Migrate all through-hole (THT) components to surface-mount (SMD) to reduce board size.
- **Simplify Temperature Sensing**: The current design uses four thermocouples, but one is sufficient. Reducing to a single thermocouple will simplify the circuit and free up microcontroller pins.
- **Isolate Mounting Holes**: The mounting holes are currently connected to the ground plane, which is not ideal. They should be isolated to prevent potential short circuits.
- **Upgrade Connectors**: The external connectors are undersized for the required current. They should be replaced with larger terminals.

---

## 🏠 Enclosure Design Notes & Improvements

The 3D model for the enclosure was designed in Autodesk Inventor. The following improvements have been identified:

- **Reduce Size**: By optimizing the PCB, the enclosure can be made smaller.
- **Improve Closure Mechanism**: The current screw-based closure can be replaced with a more practical solution like snap-fit tabs.
- **Add Accessibility**: Add openings for ventilation and easier access to connectors.
