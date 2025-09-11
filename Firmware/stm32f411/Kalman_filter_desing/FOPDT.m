% Parámetros del horno
K = 0.8;     % °C/V
tau = 120;   % s
theta = 10;  % s
T_amb = 25;  % °C

% Configuración de tiempo
t = 0:1:700; % Vector de tiempo de 0 a 700 segundos con paso de 1s
n = length(t);

% Señal de entrada (escalón de 100V en t=50s)
V_rms = zeros(1, n);
V_rms(t >= 50) = 120;

% Inicialización de temperatura
T = ones(1, n) * T_amb;

% Simulación del modelo FOPDT (First Order Plus Dead Time)
dt = t(2) - t(1); % Paso de tiempo (1s)

for i = 1:n-1
    % Manejo del retardo theta
    if t(i) > theta
        idx_delayed = find(t <= t(i) - theta, 1, 'last');
        V_delayed = V_rms(idx_delayed);
    else
        V_delayed = 0;
    end

    % Ecuación diferencial del modelo
    dTdt = (K * V_delayed + T_amb - T(i)) / tau;

    % Actualización de temperatura (método de Euler)
    T(i+1) = T(i) + dTdt * dt;
end

% Graficar resultados
figure;
plot(t, T, 'LineWidth', 2);
title('Respuesta del Sistema FOPDT');
xlabel('Tiempo (s)');
ylabel('Temperatura (°C)');
grid on;

% Añadir línea vertical en el punto de aplicación del escalón
hold on;
line([50 50], ylim, 'Color', 'r', 'LineStyle', '--');
text(55, T_amb+5, 'Escalón aplicado', 'Color', 'r');
hold off;

% Mostrar características de la respuesta
[temp_max, idx_max] = max(T);
t_max = t(idx_max);
t_63 = t(find(T >= T_amb + 0.63*(temp_max - T_amb), 1));
t_theta = t_63 - theta;

legend(sprintf('Respuesta (K=%.1f°C/V, \\tau=%ds, \\theta=%ds)', K, tau, theta), ...
       'Location', 'southeast');

% Mostrar información adicional en la gráfica
text(400, T_amb+10, sprintf('Tiempo muerto: %d s', theta), 'BackgroundColor', 'white');
text(400, T_amb+15, sprintf('Constante de tiempo: %d s', tau), 'BackgroundColor', 'white');
text(400, T_amb+20, sprintf('Ganancia: %.1f°C/V', K), 'BackgroundColor', 'white');
