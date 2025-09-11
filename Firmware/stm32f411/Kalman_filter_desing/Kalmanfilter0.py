import numpy as np
import matplotlib.pyplot as plt

# --- 1. Simulación del Horno y el Sensor ---

dt = 1.0  # El filtro se ejecuta cada 1 segundo
num_steps = 120 # Simularemos por 120 segundos

# Temperatura REAL del horno (lo que queremos adivinar)
# Sube rápido al principio y luego se estabiliza
real_temp = np.zeros(num_steps)
for t in range(1, num_steps):
    if t < 60:
        real_temp[t] = real_temp[t-1] + 3.0 * np.exp(-t/20.0) # Calentamiento no lineal
    else:
        real_temp[t] = real_temp[t-1] - 0.1 # Enfriamiento ligero

# Simulación del sensor LENTO (MAX6675)
# Usamos un promedio móvil para simular la inercia térmica
slow_sensor_temp = np.zeros(num_steps)
lag_factor = 0.9 # 0.9 = muy lento, 0.1 = muy rápido
for t in range(1, num_steps):
    slow_sensor_temp[t] = lag_factor * slow_sensor_temp[t-1] + (1 - lag_factor) * real_temp[t]

# Añadir ruido al sensor
measurement_noise_std = 0.5 # Desviación estándar del ruido en °C
noisy_sensor_temp = slow_sensor_temp + np.random.randn(num_steps) * measurement_noise_std


# --- 2. Configuración del Filtro de Kalman ---

# Matrices del modelo
# Matriz de transición de estado A: Cómo evoluciona el estado
# [temp_k] = [1 dt] [temp_k-1]
# [rate_k]   [0  1] [rate_k-1]
A = np.array([[1, dt],
              [0, 1]])

# Matriz de observación H: Cómo el estado se traduce en una medición
# Medimos solo la temperatura, no la tasa de cambio
# measurement = [1 0] * [temp, rate]'
H = np.array([[1, 0]])

# === ¡AQUÍ ESTÁ EL AJUSTE! (Tuning) ===
# Ruido del proceso (Q): Desconfianza en el modelo
# Creemos que la tasa de cambio no es constante, así que añadimos ruido ahí.
process_noise_std = 0.1
Q = np.array([[(dt**2)/2], [dt]]) * process_noise_std**2 * np.array([[(dt**2)/2, dt]])
# No te preocupes por la fórmula exacta, solo ajusta `process_noise_std`
# Un valor más alto hará que el filtro reaccione más rápido.

# Ruido de la medición (R): Desconfianza en el sensor
# Lo medimos antes: 0.5°C de desviación estándar
R = np.array([[measurement_noise_std**2]])

# Estado inicial y covarianza
x_hat = np.array([[noisy_sensor_temp[0]], [0]]) # [temp_inicial, tasa_inicial]
P = np.eye(2) * 1.0 # Incertidumbre inicial

# --- 3. Bucle del Filtro de Kalman ---
kalman_estimates = []

for k in range(num_steps):
    # --- Paso de Predicción ---
    # Predecir el siguiente estado
    x_hat_pred = A @ x_hat
    # Predecir la incertidumbre
    P_pred = A @ P @ A.T + Q

    # --- Paso de Corrección (Actualización) ---
    # Calcular la Ganancia de Kalman (K)
    K = P_pred @ H.T @ np.linalg.inv(H @ P_pred @ H.T + R)

    # Medición actual del sensor
    z = noisy_sensor_temp[k]

    # Corregir la estimación del estado
    x_hat = x_hat_pred + K @ (z - H @ x_hat_pred)
    
    # Actualizar la incertidumbre
    P = (np.eye(2) - K @ H) @ P_pred

    kalman_estimates.append(x_hat[0, 0])


# --- 4. Visualización ---
plt.figure(figsize=(12, 8))
plt.plot(real_temp, 'g-', label='Temperatura Real (Horno)')
plt.plot(noisy_sensor_temp, 'r.', markersize=3, label='Sensor Lento y Ruidoso (MAX6675)')
plt.plot(kalman_estimates, 'b-', linewidth=2, label='Estimación Filtro de Kalman')
plt.title('Filtro de Kalman para Temperatura de Horno')
plt.xlabel('Tiempo (segundos)')
plt.ylabel('Temperatura (°C)')
plt.legend()
plt.grid(True)
plt.savefig('resultado_filtro_kalman.png')
print("Gráfico guardado como 'resultado_filtro_kalman.png'")