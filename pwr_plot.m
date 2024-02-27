% Load data
data = load("pwr_comp_2.mat");
baseline_pwr = data.out.min_Pwr;
mpc_pwr = data.out.mpc_pwr; % Adjusted MPC power for comparison
%true_pwr = sum(data.out.real_pwr, 2);

% Plot power comparison
figure;

% Plot Baseline Power vs True Power
subplot(2, 1, 1);
plot(mpc_pwr, 'r', 'LineWidth', 2); hold on;
plot(baseline_pwr, 'b', 'LineWidth', 2);
xlabel('Time');
ylabel('Power');
title('MPC Power vs Baseline Power');
legend('MPC Power', 'Baseline Power');
grid on;

% Plot MPC Power vs True Power
subplot(2, 1, 2);
plot(mpc_pwr, 'r', 'LineWidth', 2);
hold on;
plot(baseline_pwr, 'g', 'LineWidth', 2);
xlabel('Time');
ylabel('Power');
title('MPC Power vs True Power');
legend('MPC Power', 'True Power');
grid on;
