% Load difference data
Points = load("Analysis.mat");
high = Points.high;
low = Points.low;

% x axis
step=1:247401;

% when mpc consumed less SOC then Baseline per step
high_base_trq1 = high(:, 2);
high_base_trq2 = high(:, 3);
high_base_pwr = high(:, 4);
high_mpc_trq1 = high(:, 5);
high_mpc_trq2 = high(:, 6);
high_mpc_pwr = high(:, 7);

% when mpc consumed more SOC then Baseline per step
low_base_trq1 = low(:, 2);
low_base_trq2 = low(:, 3);
low_base_pwr = low(:, 4);
low_mpc_trq1 = low(:, 5);
low_mpc_trq2 = low(:, 6);
low_mpc_pwr = low(:, 7);


% Create figure for high-end differences
figure;
subplot(2, 3, 1);
plot(high_velocity, 'b-', 'LineWidth', 2);
title('Velocity (High End)');

subplot(2, 3, 2);
plot(high_trq1, 'b-', 'LineWidth', 2);
title('Trq1 (High End)');

subplot(2, 3, 3);
plot(high_trq2, 'b-', 'LineWidth', 2);
title('Trq2 (High End)');

subplot(2, 3, 4);
plot(high_total_trq, 'b-', 'LineWidth', 2);
title('Total Trq (High End)');

subplot(2, 3, 5);
plot(high_SOC, 'b-', 'LineWidth', 2);
title('SOC (High End)');

% Add labels and titles
sgtitle('Differences in Variables between MPC and Baseline (High End)');

% Create figure for low-end differences
figure;
subplot(2, 3, 1);
plot(low_velocity, 'r--', 'LineWidth', 2);
title('Velocity (Low End)');

subplot(2, 3, 2);
plot(low_trq1, 'r--', 'LineWidth', 2);
title('Trq1 (Low End)');

subplot(2, 3, 3);
plot(low_trq2, 'r--', 'LineWidth', 2);
title('Trq2 (Low End)');

subplot(2, 3, 4);
plot(low_total_trq, 'r--', 'LineWidth', 2);
title('Total Trq (Low End)');

subplot(2, 3, 5);
plot(low_SOC, 'r--', 'LineWidth', 2);
title('SOC (Low End)');

% Add labels and titles
sgtitle('Differences in Variables between MPC and Baseline (Low End)');
