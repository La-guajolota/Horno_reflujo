<!-- @format -->

# Reflow Oven Hardware Project

Welcome to the Reflow Oven Hardware repository! This project contains all the design files, documentation, and resources needed to build and understand a custom reflow oven for PCB assembly. The repository is organized to facilitate hardware development, fabrication, and production processes using KiCad and related tools.

## Project Structure

- **horno_no_modificado/**: Contains the original, unmodified oven schematic files and backups.
- **horno_reflujo/**: Main folder for the reflow oven hardware, including:
  - KiCad project files (`.kicad_pcb`, `.kicad_sch`, `.kicad_pro`, etc.)
  - Symbol libraries and configuration files
  - **bom/**: Interactive BOM and related documentation
  - **production/**: Files for manufacturing, including BOM, netlist, positions, and zipped production packages
  - **backups/**: Automated backups of project files
- **imagenes/**: Reference images, schematics, and documentation PDFs

## Features

- Complete KiCad project for a reflow oven PCB
- Interactive BOM for easy component sourcing
- Production-ready files for PCB manufacturing and assembly
- Backup system to prevent data loss
- Visual documentation for hardware reference

## Getting Started

1. **Clone the Repository**
   ```sh
   git clone <repo-url>
   ```
2. **Open the Project in KiCad**
   - Navigate to `horno_reflujo/` and open `horno_reflujo.kicad_pro`.
3. **Review Schematics and PCB Layout**
   - Use KiCad to explore the schematic (`.kicad_sch`) and PCB (`.kicad_pcb`) files.
4. **Generate BOM and Production Files**
   - Refer to the `bom/` and `production/` folders for manufacturing resources.

## TODO

- [ ] Add detailed assembly instructions for the oven hardware
- [ ] Include safety guidelines and troubleshooting tips
- [ ] Translate documentation to Engliish

## Contact

For questions or contributions, please open an issue or contact the project maintainer.
