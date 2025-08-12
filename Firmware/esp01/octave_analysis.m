pkg load io  % para leer archivos Excel

% Leer el archivo y hoja
[data, txt, raw] = xlsread("/media/adrian/usb_a/Chambas/Inbiodroid/Horno_reflujo/Firmware/esp01/regresion_horno.xlsx", "Sensor de techo");

% Extraer columnas (suponiendo que columna 1 = Tiempo, columna 2 = Temperatura)
tiempo = data(:, 1);
temperatura = data(:, 2);

% Pedir cuántos puntos quieres
n = input("¿Cuántos puntos quieres usar?: ");

% Limitar a n puntos
tiempo = tiempo(1:n);
temperatura = temperatura(1:n);

% Crear vector de tiempo más denso para las curvas suaves
t_fine = linspace(min(tiempo), max(tiempo), 200);

% ========== REGRESIÓN LINEAL ==========
p_linear = polyfit(tiempo, temperatura, 1);
y_linear = polyval(p_linear, t_fine);
r2_linear = corrcoef(temperatura, polyval(p_linear, tiempo))^2;
r2_linear = r2_linear(1,2);

% ========== REGRESIÓN POLINÓMICA ==========
grado = input("¿Grado de regresión polinómica?: ");
p_poly = polyfit(tiempo, temperatura, grado);
y_poly = polyval(p_poly, t_fine);
r2_poly = corrcoef(temperatura, polyval(p_poly, tiempo))^2;
r2_poly = r2_poly(1,2);

% ========== REGRESIÓN LOGARÍTMICA ==========
% Forma: y = a * ln(x) + b
% Verificar que todos los valores de tiempo sean positivos
if min(tiempo) <= 0
    tiempo_log = tiempo - min(tiempo) + 1; % Desplazar para evitar log(0)
    t_fine_log = t_fine - min(tiempo) + 1;
    warning('Se desplazaron los valores de tiempo para evitar log(0)');
else
    tiempo_log = tiempo;
    t_fine_log = t_fine;
end

X_log = [log(tiempo_log), ones(length(tiempo_log), 1)];
coeff_log = X_log \ temperatura;
a_log = coeff_log(1);
b_log = coeff_log(2);
y_log = a_log * log(t_fine_log) + b_log;

% Calcular R² para logarítmica
y_log_original = a_log * log(tiempo_log) + b_log;
ss_res_log = sum((temperatura - y_log_original).^2);
ss_tot_log = sum((temperatura - mean(temperatura)).^2);
r2_log = 1 - (ss_res_log / ss_tot_log);

% ========== REGRESIÓN EXPONENCIAL ==========
% Forma: y = a * e^(b*x)
% Linearizar: ln(y) = ln(a) + b*x
% Verificar valores positivos de temperatura para el logaritmo
if min(temperatura) <= 0
    temp_exp = temperatura - min(temperatura) + 1;
    warning('Se desplazaron los valores de temperatura para regresión exponencial');
else
    temp_exp = temperatura;
end

X_exp = [tiempo, ones(length(tiempo), 1)];
coeff_exp = X_exp \ log(temp_exp);
b_exp = coeff_exp(1);
ln_a_exp = coeff_exp(2);
a_exp = exp(ln_a_exp);

if min(temperatura) <= 0
    y_exp = a_exp * exp(b_exp * t_fine) + min(temperatura) - 1;
    y_exp_original = a_exp * exp(b_exp * tiempo) + min(temperatura) - 1;
else
    y_exp = a_exp * exp(b_exp * t_fine);
    y_exp_original = a_exp * exp(b_exp * tiempo);
end

% Calcular R² para exponencial
ss_res_exp = sum((temperatura - y_exp_original).^2);
ss_tot_exp = sum((temperatura - mean(temperatura)).^2);
r2_exp = 1 - (ss_res_exp / ss_tot_exp);

% ========== GRÁFICA ==========
figure;
plot(tiempo, temperatura, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'black', 'DisplayName', 'Datos originales');
hold on;
plot(t_fine, y_linear, '-b', 'LineWidth', 2, 'DisplayName', sprintf('Lineal (R² = %.4f)', r2_linear));
plot(t_fine, y_poly, '-r', 'LineWidth', 2, 'DisplayName', sprintf('Polinómica grado %d (R² = %.4f)', grado, r2_poly));
plot(t_fine_log, y_log, '-g', 'LineWidth', 2, 'DisplayName', sprintf('Logarítmica (R² = %.4f)', r2_log));
plot(t_fine, y_exp, '-m', 'LineWidth', 2, 'DisplayName', sprintf('Exponencial (R² = %.4f)', r2_exp));

xlabel('Tiempo (ms)');
ylabel('Temperatura (°C)');
title('Comparación de Regresiones - Medición de temperatura con entrada escalón');
grid on;
legend('show', 'Location', 'best');
hold off;

% ========== MOSTRAR ECUACIONES ==========
fprintf('\n========== ECUACIONES DE REGRESIÓN ==========\n');
fprintf('Lineal: y = %.4fx + %.4f\n', p_linear(1), p_linear(2));

fprintf('Polinómica (grado %d): y = ', grado);
for i = 1:length(p_poly)
    if i == 1
        fprintf('%.4fx^%d', p_poly(i), length(p_poly)-1);
    elseif i == length(p_poly)
        if p_poly(i) >= 0
            fprintf(' + %.4f', p_poly(i));
        else
            fprintf(' - %.4f', abs(p_poly(i)));
        end
    else
        if p_poly(i) >= 0
            fprintf(' + %.4fx^%d', p_poly(i), length(p_poly)-i);
        else
            fprintf(' - %.4fx^%d', abs(p_poly(i)), length(p_poly)-i);
        end
    end
end
fprintf('\n');

fprintf('Logarítmica: y = %.4f*ln(x) + %.4f\n', a_log, b_log);
fprintf('Exponencial: y = %.4f*e^(%.4fx)\n', a_exp, b_exp);

fprintf('\n========== COEFICIENTES R² ==========\n');
fprintf('R² Lineal: %.6f\n', r2_linear);
fprintf('R² Polinómica: %.6f\n', r2_poly);
fprintf('R² Logarítmica: %.6f\n', r2_log);
fprintf('R² Exponencial: %.6f\n', r2_exp);

% Encontrar el mejor ajuste
[max_r2, best_idx] = max([r2_linear, r2_poly, r2_log, r2_exp]);
modelos = {'Lineal', 'Polinómica', 'Logarítmica', 'Exponencial'};
fprintf('\nMejor ajuste: %s (R² = %.6f)\n', modelos{best_idx}, max_r2);
