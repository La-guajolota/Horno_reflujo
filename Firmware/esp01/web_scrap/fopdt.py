import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

def analyze_fopdt(df, time_col='tiempo (seg)', temp_col='Temperatura (°C)', power_col='Potencia'):
    """
    Analiza un DataFrame para encontrar las constantes de un modelo FOPDT
    a partir de una respuesta a un escalón.
    """
    # 1. Limpiar nombres de columnas para eliminar espacios extra
    df.columns = df.columns.str.strip()
    
    # 2. Identificar el escalón en la entrada (Potencia)
    if power_col not in df.columns:
        raise KeyError(f"La columna '{power_col}' no se encuentra en los datos. Columnas disponibles: {df.columns.tolist()}")

    power_diff = df[power_col].diff().abs()
    step_index = power_diff.nlargest(2).idxmin()
    time_of_step = df.loc[step_index, time_col]
    
    # 3. Obtener valores iniciales y finales
    p_initial = df.loc[step_index - 1, power_col]
    p_final = df.loc[step_index, power_col]
    
    t_initial = df.loc[step_index - 1, temp_col]
    t_final = df.iloc[-1][temp_col]
    
    delta_p = p_final - p_initial
    delta_t = t_final - t_initial
    
    # 4. Calcular la Ganancia del Proceso (Kp)
    kp = delta_t / delta_p if delta_p != 0 else np.nan
        
    # 5. Calcular el Tiempo Muerto (theta)
    df_after_step = df[df[time_col] >= time_of_step]
    first_response_index = df_after_step[df_after_step[temp_col] > t_initial].index.min()
    
    theta = np.nan
    if pd.notna(first_response_index):
        time_of_first_response = df.loc[first_response_index, time_col]
        theta = time_of_first_response - time_of_step
        
    # 6. Calcular la Constante de Tiempo (tau)
    t_at_63_percent = t_initial + 0.632 * delta_t
    time_at_63_percent_index = df_after_step[df_after_step[temp_col] >= t_at_63_percent].index.min()
    
    tau = np.nan
    time_at_63_percent = None
    if pd.notna(time_at_63_percent_index):
        time_at_63_percent = df.loc[time_at_63_percent_index, time_col]
        if pd.notna(theta):
            tau = time_at_63_percent - (time_of_step + theta)

    return {
        'Kp': kp, 'theta': theta, 'tau': tau, 't_initial': t_initial, 't_final': t_final,
        'time_of_step': time_of_step, 't_at_63_percent': t_at_63_percent,
        'time_at_63_percent': time_at_63_percent
    }

# --- Ejecución Principal ---
# Nombre de tu archivo Excel y las hojas a analizar
excel_file = 'regresion_horno2.xlsx'
sheets_to_analyze = ['naked', 'covered']

results = {}

try:
    for sheet in sheets_to_analyze:
        # Leer la hoja específica del archivo Excel
        df = pd.read_excel(excel_file, sheet_name=sheet)
        results[sheet] = analyze_fopdt(df)
        
except FileNotFoundError:
    print(f"Error: No se encontró el archivo '{excel_file}'. Asegúrate de que esté en la misma carpeta.")
    exit()
except Exception as e:
    print(f"Ocurrió un error: {e}")
    exit()

# --- Mostrar Resultados y Gráficas ---
for sheet, params in results.items():
    print(f"--- Resultados para la hoja: '{sheet}' ---")
    if np.isnan(params['Kp']):
        print("No se pudieron calcular los parámetros. Revisa los datos.\n")
        continue
    
    print(f"Ganancia del Proceso (Kp): {params['Kp']:.4f} °C/%")
    print(f"Tiempo Muerto (theta): {params['theta']:.2f} segundos")
    print(f"Constante de Tiempo (tau): {params['tau']:.2f} segundos\n")

    # Graficar
    df = pd.read_excel(excel_file, sheet_name=sheet)
    df.columns = df.columns.str.strip()

    plt.style.use('seaborn-v0_8-whitegrid')
    fig, ax = plt.subplots(figsize=(12, 7))
    
    ax.plot(df['tiempo (seg)'], df['Temperatura (°C)'], label='Respuesta del Sistema', color='blue')
    # ... (resto del código de graficación es igual)
    ax.axhline(params['t_initial'], color='gray', linestyle='--', label=f'T inicial: {params["t_initial"]:.2f}°C')
    ax.axhline(params['t_final'], color='gray', linestyle='--', label=f'T final: {params["t_final"]:.2f}°C')
    ax.axhline(params['t_at_63_percent'], color='red', linestyle=':', label=f'63.2% del cambio ({params["t_at_63_percent"]:.2f}°C)')
    
    if params['time_at_63_percent']:
        ax.axvline(params['time_at_63_percent'], color='red', linestyle=':')
    
    if pd.notna(params['theta']):
        t_start_response = params['time_of_step'] + params['theta']
        ax.axvspan(params['time_of_step'], t_start_response, alpha=0.2, color='orange', label=f'Tiempo Muerto (θ ≈ {params["theta"]:.2f}s)')
        if pd.notna(params['tau']) and params['time_at_63_percent']:
             ax.axvspan(t_start_response, params['time_at_63_percent'], alpha=0.2, color='green', label=f'Constante de Tiempo (τ ≈ {params["tau"]:.2f}s)')
    
    ax.set_title(f'Análisis de Respuesta al Escalón - Hoja "{sheet}"', fontsize=16)
    ax.set_xlabel('Tiempo (segundos)')
    ax.set_ylabel('Temperatura (°C)')
    ax.legend()
    plt.show()
