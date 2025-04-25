# 🔥 Horno de Soldadura SMD

Este proyecto ofrece un diseño abierto para **soldar componentes SMD** mediante tecnología de reflujo, con control preciso de temperatura y ventilación integrada, optimizando la producción de PCBs de hasta 15x15 cm.

---

## 📑 Contenidos

1. [Descripción General](#descripción-general)  
2. [Características Principales](#características-principales)  
3. [Flujo de Trabajo](#flujo-de-trabajo)  
4. [Retos Técnicos](#retos-técnicos)  
5. [Estructura del Repositorio](#estructura-del-repositorio)  
6. [Requisitos y Dependencias](#requisitos-y-dependencias)  
7. [Instalación y Uso](#instalación-y-uso)  
8. [Colaboradores](#colaboradores)  
9. [Licencia](#licencia)  

---

## Descripción General

El **Horno de Soldadura SMD** permite:  
- Soldar componentes SMD mediante **pasta de soldadura** y perfiles térmicos configurables.  
- Procesar PCBs de **hasta 15x15 cm**.  
- Controlar la curva de temperatura en tiempo real para evitar defectos.  
- Gestionar vapores tóxicos mediante un sistema de **ventilación integrado**.  
- Interfaz intuitiva con **pantalla táctil** para operación y monitoreo.  

Diseño modular y accesible para prototipado rápido y adaptación a diferentes entornos de producción.

---

## ✨ Características Principales

- **Control térmico**: Perfiles personalizables para distintos tipos de soldadura.  
- **Distribución uniforme**: Calentamiento homogéneo en toda la superficie de la PCB.  
- **Seguridad**: Sistema de paro de emergencia por sobrecalentamiento.  
- **Interfaz gráfica**: Menús configurables y visualización de la curva de temperatura en pantalla táctil.  
- **Documentación completa**: Diagramas de flujo, listas de materiales y guías de calibración.  

---

## 🔄 Flujo de Trabajo

1. **Preparación de la PCB**  
   - Aplicar pasta de soldadura con esténcil o dispensador.  
   - Colocar componentes SMD con pinzas o máquina Pick & Place.  

2. **Configuración del horno**  
   - Seleccionar perfil térmico según el tipo de soldadura.  
   - Precalentar el horno para estabilizar temperaturas.  

3. **Proceso de soldadura**  
   - Introducir la PCB en el horno.  
   - Ejecutar curva de temperatura:  
     1. **Precalentamiento**: Evaporar solventes de la pasta (100-150°C).  
     2. **Remojo**: Igualar temperatura en toda la PCB (150-180°C).  
     3. **Reflujo**: Fundir soldadura (pico de 220-250°C).  
     4. **Enfriamiento controlado**: Reducir estrés térmico (<100°C).  

4. **Inspección final**  
   - Revisar uniones con lupa o microscopio.  
   - Realizar pruebas eléctricas para detectar cortos.  
   - Corregir soldaduras defectuosas manualmente.  

---

## 🎯 Retos Técnicos

1. **Control de temperatura**  
   - Distribución uniforme en toda la cámara del horno.  
   - Adaptación a diferentes curvas térmicas según material.  
   - Evitar microgrietas por enfriamiento rápido.  

2. **Gestión de riesgos**  
   - Detección automática de sobrecalentamiento (paro de emergencia).  
   - Filtrado de vapores tóxicos durante el proceso.  

3. **Precisión operativa**  
   - Calibración de sensores térmicos.  
   - Sincronización entre etapas de calentamiento/enfriamiento.  

---

## 📂 Estructura del Repositorio

```text
.
├── Electrónica/               # Esquemas de control térmico y PCB
├── Mecánica/                  # Diseño 3D del horno y sistema de ventilación
├── Firmware/                  # Código para pantalla táctil y sensores
├── Perfiles_Térmicos/         # Configuraciones predefinidas para soldaduras
├── Documentación/             # Manuales de uso y protocolos de seguridad
├── LICENSE                    # Licencia MIT
└── README.md                  # Guía principal del proyecto