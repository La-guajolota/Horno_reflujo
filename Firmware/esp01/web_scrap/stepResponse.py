import pandas as pd
import matplotlib.pyplot as plt

# --- Configuración ---
# Reemplaza 'tu_archivo.xlsx' con el nombre de tu archivo de Excel.
excel_file = './regresion_horno2.xlsx' 
sheet_naked = 'naked'
sheet_covered = 'covered'

# Columnas que vamos a usar para la gráfica
time_column = 'tiempo (seg)'
temperature_column = 'Temperatura (°C)'
power_colum = 'Potencia'

try:
    # --- Cargar los datos de las hojas de Excel ---
    # Leemos la hoja 'naked'
    df_naked = pd.read_excel(excel_file, sheet_name=sheet_naked)
    
    # Leemos la hoja 'covered'
    df_covered = pd.read_excel(excel_file, sheet_name=sheet_covered)

    # --- Creación de la Gráfica ---
    plt.style.use('seaborn-v0_8-whitegrid') # Estilo de la gráfica
    fig, ax = plt.subplots(figsize=(12, 7)) # Tamaño de la figura

    # Graficar la curva de temperatura para 'naked'
    ax.plot(df_naked[time_column], df_naked[temperature_column], 
            label='Temperatura (Naked)', marker='o', linestyle='-')

    # Graficar la curva de temperatura para 'covered'
    ax.plot(df_covered[time_column], df_covered[temperature_column], 
            label='Temperatura (Covered)', marker='x', linestyle='--')

    # --- Personalización de la Gráfica ---
    ax.set_title('Comparación de Curvas de Temperatura', fontsize=16)
    ax.set_xlabel('Tiempo (segundos)', fontsize=12)
    ax.set_ylabel('Temperatura (°C)', fontsize=12)
    ax.legend() # Muestra las etiquetas de cada curva
    ax.grid(True) # Activa la cuadrícula

    # Mostrar la gráfica
    plt.tight_layout() # Ajusta el layout
    plt.show()

except FileNotFoundError:
    print(f"Error: No se encontró el archivo '{excel_file}'.")
    print("Asegúrate de que el archivo esté en la misma carpeta que el script o proporciona la ruta completa.")
except KeyError as e:
    print(f"Error: No se encontró la columna {e} en una de las hojas.")
    print(f"Por favor, verifica que los nombres de las columnas sean exactamente '{time_column}' y '{temperature_column}'.")
