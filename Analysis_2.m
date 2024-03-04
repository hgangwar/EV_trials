% Load difference data
Points = load("highlight.mat");
high = Points.high;
low = Points.low;

% Extract data for high and low ends
high_velocity = high(:, 1);
high_trq1 = high(:, 2);
high_trq2 = high(:, 3);
high_total_trq = high(:, 4);
high_SOC = high(:, 5);

low_velocity = low(:, 1);
low_trq1 = low(:, 2);
low_trq2 = low(:, 3);
low_total_trq = low(:, 4);
low_SOC = low(:, 5);

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
