pkg load io  % Load package for reading Excel files

% Read Excel file
[data, txt, raw] = xlsread("/media/adrian/usb_a/Chambas/Inbiodroid/Horno_reflujo/Firmware/esp01/web_scrap/regresion_horno.xlsx", "Sensor de techo");

% Extract columns
time = data(:, 1);
temperature = data(:, 2);

% Ask for number of points to use
n = input("How many points do you want to use?: ");

% Limit to n points
time = time(200:n);
temperature = temperature(200:n);

% Create dense time vector for smooth curves
t_fine = linspace(min(time), max(time), 200);

% ========== LINEAR REGRESSION ==========
p_linear = polyfit(time, temperature, 1);
y_linear = polyval(p_linear, t_fine);
y_linear_original = polyval(p_linear, time);
ss_res_linear = sum((temperature - y_linear_original).^2);
ss_tot_linear = sum((temperature - mean(temperature)).^2);
r2_linear = 1 - (ss_res_linear / ss_tot_linear);

% ========== POLYNOMIAL REGRESSION ==========
degree = input("Polynomial regression degree?: ");
p_poly = polyfit(time, temperature, degree);
y_poly = polyval(p_poly, t_fine);
y_poly_original = polyval(p_poly, time);
ss_res_poly = sum((temperature - y_poly_original).^2);
ss_tot_poly = sum((temperature - mean(temperature)).^2);
r2_poly = 1 - (ss_res_poly / ss_tot_poly);

% ========== LOGARITHMIC REGRESSION ==========
if min(time) <= 0
    time_log = time - min(time) + 1;
    t_fine_log = t_fine - min(time) + 1;
    warning('Time values shifted to avoid log(0)');
else
    time_log = time;
    t_fine_log = t_fine;
end

X_log = [log(time_log), ones(length(time_log), 1)];
coeff_log = X_log \ temperature;
a_log = coeff_log(1);
b_log = coeff_log(2);
y_log = a_log * log(t_fine_log) + b_log;

% Calculate R² for logarithmic
y_log_original = a_log * log(time_log) + b_log;
ss_res_log = sum((temperature - y_log_original).^2);
ss_tot_log = sum((temperature - mean(temperature)).^2);
r2_log = 1 - (ss_res_log / ss_tot_log);

% ========== EXPONENTIAL REGRESSION ==========
if min(temperature) <= 0
    temp_exp = temperature - min(temperature) + 1;
    warning('Temperature values shifted for exponential regression');
else
    temp_exp = temperature;
end

X_exp = [time, ones(length(time), 1)];
coeff_exp = X_exp \ log(temp_exp);
b_exp = coeff_exp(1);
ln_a_exp = coeff_exp(2);
a_exp = exp(ln_a_exp);

if min(temperature) <= 0
    y_exp = a_exp * exp(b_exp * t_fine) + min(temperature) - 1;
    y_exp_original = a_exp * exp(b_exp * time) + min(temperature) - 1;
else
    y_exp = a_exp * exp(b_exp * t_fine);
    y_exp_original = a_exp * exp(b_exp * time);
end

% Calculate R² for exponential
ss_res_exp = sum((temperature - y_exp_original).^2);
ss_tot_exp = sum((temperature - mean(temperature)).^2);
r2_exp = 1 - (ss_res_exp / ss_tot_exp);

% ========== INVERSE EXPONENTIAL REGRESSION (RC CHARGE) ==========
fprintf('\n========== INVERSE EXPONENTIAL REGRESSION ==========\n');

% Prepare data for RC charge model
t0 = time(1);
y0 = temperature(1);
t_rel = time - t0;
y_shift = temperature - y0;

% Search range for A (amplitude)
A_min = max(y_shift) * 1.01;
A_max = max(y_shift) * 3;
A_range = linspace(A_min, A_max, 150);

% Initialize best parameters
best_r2_inv_exp = -Inf;
best_A = 0;
best_B = 0;

for A = A_range
    % Select valid points
    valid_idx = (y_shift < A) & (y_shift >= 0);

    if sum(valid_idx) < 5
        continue;
    end

    t_valid = t_rel(valid_idx);
    y_valid = y_shift(valid_idx);

    % Linear transformation
    z = log(1 - y_valid / A);

    % Linear regression (no intercept)
    B = - (t_valid \ z);

    % Validate positive B
    if B <= 0
        continue;
    end

    % Calculate predictions
    y_pred_shift = A * (1 - exp(-B * t_valid));
    y_pred = y0 + y_pred_shift;

    % Calculate R²
    ss_res = sum((temperature(valid_idx) - y_pred).^2);
    ss_tot = sum((temperature(valid_idx) - mean(temperature(valid_idx))).^2);
    r2 = 1 - (ss_res / max(ss_tot, eps));

    % Update best parameters
    if r2 > best_r2_inv_exp
        best_r2_inv_exp = r2;
        best_A = A;
        best_B = B;
    end
end

% Calculate smooth curve for plotting
t_fine_rel = t_fine - t0;
y_inv_exp_fine = y0 + best_A * (1 - exp(-best_B * t_fine_rel));

% Calculate R² for all points
y_inv_exp_all = y0 + best_A * (1 - exp(-best_B * t_rel));
ss_res_inv_exp = sum((temperature - y_inv_exp_all).^2);
ss_tot_inv_exp = sum((temperature - mean(temperature)).^2);
r2_inv_exp = 1 - (ss_res_inv_exp / ss_tot_inv_exp);

% ========== MAIN PLOT WITH ALL REGRESSIONS ==========
figure;
plot(time, temperature, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'black');
hold on;
plot(t_fine, y_linear, '-b', 'LineWidth', 2);
plot(t_fine, y_poly, '-r', 'LineWidth', 2);
plot(t_fine_log, y_log, '-g', 'LineWidth', 2);
plot(t_fine, y_exp, '-m', 'LineWidth', 2);
plot(t_fine, y_inv_exp_fine, '-c', 'LineWidth', 2);

xlabel('Time (ms)');
ylabel('Temperature (°C)');
title('Regression Comparison - Temperature Measurement with Step Input');
grid on;
legend({'Original data', ...
        sprintf('Linear (R² = %.4f)', r2_linear), ...
        sprintf('Polynomial deg %d (R² = %.4f)', degree, r2_poly), ...
        sprintf('Logarithmic (R² = %.4f)', r2_log), ...
        sprintf('Exponential (R² = %.4f)', r2_exp), ...
        sprintf('Inverse Exp. (R² = %.4f)', r2_inv_exp)}, ...
        'Location', 'northeast');
hold off;

% ========== DISPLAY EQUATIONS ==========
fprintf('\n========== REGRESSION EQUATIONS ==========\n');
fprintf('Linear: y = %.6ex + %.6e\n', p_linear(1), p_linear(2));

fprintf('Polynomial (deg %d): y = ', degree);
for i = 1:length(p_poly)
    pow = length(p_poly) - i;
    if i == 1
        fprintf('%.6ex^%d', p_poly(i), pow);
    elseif i == length(p_poly)
        if p_poly(i) >= 0
            fprintf(' + %.6e', p_poly(i));
        else
            fprintf(' - %.6e', abs(p_poly(i)));
        end
    else
        if p_poly(i) >= 0
            fprintf(' + %.6ex^%d', p_poly(i), pow);
        else
            fprintf(' - %.6ex^%d', abs(p_poly(i)), pow);
        end
    end
end
fprintf('\n');

fprintf('Logarithmic: y = %.6e*ln(x) + %.6e\n', a_log, b_log);
fprintf('Exponential: y = %.6e*e^(%.6ex)\n', a_exp, b_exp);
fprintf('Inverse Exponential: y = %.6e + %.6e*(1 - exp(-%.6e*(t - %.6e)))\n', ...
        y0, best_A, best_B, t0);

% ========== R² COMPARISON ==========
fprintf('\n========== R² VALUES ==========\n');
fprintf('Linear R²: %.6f (%.2f%%)\n', r2_linear, r2_linear*100);
fprintf('Polynomial R²: %.6f (%.2f%%)\n', r2_poly, r2_poly*100);
fprintf('Logarithmic R²: %.6f (%.2f%%)\n', r2_log, r2_log*100);
fprintf('Exponential R²: %.6f (%.2f%%)\n', r2_exp, r2_exp*100);
fprintf('Inverse Exponential R²: %.6f (%.2f%%)\n', r2_inv_exp, r2_inv_exp*100);

% Find best model
models = {'Linear', 'Polynomial', 'Logarithmic', 'Exponential', 'Inverse Exponential'};
r2_values = [r2_linear, r2_poly, r2_log, r2_exp, r2_inv_exp];
[max_r2, best_idx] = max(r2_values);
fprintf('\nBest model: %s (R² = %.6f - %.2f%%)\n', models{best_idx}, max_r2, max_r2*100);

% ========== LAPLACE TRANSFORM ANALYSIS ==========
fprintf('\n========== LAPLACE TRANSFORM OF BEST MODEL ==========\n');
fprintf('Selected model: %s\n', models{best_idx});

switch best_idx
    case 1  % Linear
        fprintf('Linear model: y(t) = %.6e*t + %.6e\n', p_linear(1), p_linear(2));
        fprintf('Laplace transform: Y(s) = %.6e/s² + %.6e/s\n', p_linear(1), p_linear(2));

    case 2  % Polynomial
        fprintf('Polynomial model (deg %d):\n', degree);
        fprintf('y(t) = ');
        for i = 1:length(p_poly)
            pow = length(p_poly) - i;
            if i == 1
                fprintf('%.6e*t^%d', p_poly(i), pow);
            else
                if p_poly(i) >= 0
                    fprintf(' + %.6e*t^%d', p_poly(i), pow);
                else
                    fprintf(' - %.6e*t^%d', abs(p_poly(i)), pow);
                end
            end
        end
        fprintf('\n');

    case 3  % Logarithmic
        fprintf('Logarithmic model: y(t) = %.6e*ln(t) + %.6e\n', a_log, b_log);
        fprintf('NOTE: Laplace transform of ln(t) has no simple closed form\n');

    case 4  % Exponential
        fprintf('Exponential model: y(t) = %.6e*e^(%.6e*t)\n', a_exp, b_exp);
        if b_exp ~= 0
            fprintf('Laplace transform: Y(s) = %.6e/(s - %.6e)\n', a_exp, b_exp);
        else
            fprintf('Laplace transform: Y(s) = %.6e/s\n', a_exp);
        end

    case 5  % Inverse Exponential
        fprintf('Inverse Exponential model: y(t) = %.6e + %.6e*(1 - exp(-%.6e*(t - %.6e)))\n', ...
                y0, best_A, best_B, t0);
        fprintf('Considering step response from t0:\n');
        fprintf('Δy(t) = %.6e*(1 - exp(-%.6e*t))\n', best_A, best_B);
        fprintf('Input: u(t) = 120.0 * step(t)\n');
        fprintf('Laplace transform of Δy(t):\n');
        fprintf('ΔY(s) = %.6e * [1/s - 1/(s+%.6e)]\n', best_A, best_B);
        fprintf('Transfer function: H(s) = %.6e / (s + %.6e)\n', best_A*best_B/120.0, best_B);
end

% ========== SYSTEM ANALYSIS ==========
fprintf('\n========== SYSTEM ANALYSIS ==========\n');
if best_idx == 5
    fprintf('First-order system characteristics:\n');
    fprintf('Steady-state gain: K = %.6e\n', best_A/120.0);
    fprintf('Time constant: τ = %.6e seconds\n', 1/best_B);
    fprintf('Pole location: s = %.6e\n', -best_B);

    if best_B > 0
        fprintf('Stable system (pole in left-half plane)\n');
        fprintf('Settling time (2%%): %.4f seconds\n', 4/best_B);
    else
        fprintf('UNSTABLE system (pole in right-half plane)\n');
    end
end
