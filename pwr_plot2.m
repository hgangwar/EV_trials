% Load data
data = load("pwr_comp.mat");
baseline_pwr = data.out.min_Pwr;
mpc_pwr = data.out.mpc_pwr / 10; % Adjusted MPC power for comparison
true_pwr = sum(data.out.real_pwr, 2);

% Plot power comparison
figure;

% Plot Baseline Power
subplot(3, 1, 1);
plot(baseline_pwr, 'r', 'LineWidth', 2);
xlabel('Time');
ylabel('Power');
title('Baseline Power');
grid on;

% Plot MPC Power
subplot(3, 1, 2);
plot(mpc_pwr, 'b', 'LineWidth', 2);
xlabel('Time');
ylabel('Power');
title('MPC Power');
grid on;

% Plot True Power
subplot(3, 1, 3);
plot(baseline_pwr, 'r', 'LineWidth', 2); hold on;
plot(mpc_pwr, 'b', 'LineWidth', 2);
plot(true_pwr, 'g', 'LineWidth', 2);
xlabel('Time');
ylabel('Power');
title('Power Comparison');
legend('Baseline Power', 'MPC Power', 'True Power');
grid on;

% Adjust subplot layout
sgtitle('Power Comparison');
