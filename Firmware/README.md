<!-- @format -->

# Firmware para Horno de Reflujo

Este directorio contiene el firmware y utilidades de software para el proyecto de horno de reflujo. Aquí se encuentran los archivos y documentación necesarios para el desarrollo, prueba y comunicación con los diferentes módulos electrónicos del sistema.

## Estructura del Proyecto

- **esp01/**: Código y recursos para el microcontrolador ESP01.
  - **esp01_webGUI/**: Proyecto PlatformIO para el ESP01 con interfaz web.
  - **serial_debug/**: Scripts de Python para depuración y comunicación serial.
    - `serialTest.py`: Pruebas de comunicación serial.
    - `serialUtils.py`: Utilidades para manejo de datos seriales.
  - **web_scrap/**: Herramientas para análisis de datos y web scraping.
    - `fopdt.py`, `stepResponse.py`: Modelado y análisis de respuesta de sistemas.
    - `regresion_horno.xlsx`, `regresion_horno2.xlsx`: Datos de regresión y análisis.
    - `web_client.py`: Cliente web para interacción y pruebas.

## Características

- Proyectos PlatformIO listos para microcontroladores ESP01.
- Scripts de depuración y comunicación serial en Python.
- Herramientas para análisis de datos y modelado de sistemas térmicos.
- Documentación y ejemplos para facilitar el desarrollo y pruebas.

## Cómo empezar

1. **Clona el repositorio**
   ```sh
   git clone <repo-url>
   ```
2. **Explora los subdirectorios**
   - Abre los proyectos PlatformIO en `esp01_webGUI/` para desarrollo en ESP01.
   - Utiliza los scripts Python en `serial_debug/` y `web_scrap/` para pruebas y análisis.
3. **Consulta la documentación**
   - Revisa los archivos README y los scripts para instrucciones específicas de uso.

## TODO

- [ ] Add detailed assembly instructions for the oven hardware
- [ ] Include safety guidelines and troubleshooting tips
- [ ] Translate documentation to Engliish

## Contact

For questions or contributions, please open an issue or contact the project maintainer.
