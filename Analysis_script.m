% Load difference data
load("Analysis.mat");
high = Analysis.high;
low = Analysis.low;

% Extracting data from high and low structures
high_base_trq1 = high(:, 2);
high_base_trq2 = high(:, 3);
high_base_pwr = high(:, 4);
high_mpc_trq1 = high(:, 5);
high_mpc_trq2 = high(:, 6);
high_mpc_pwr = high(:, 7);

low_base_trq1 = low(:, 2);
low_base_trq2 = low(:, 3);
low_base_pwr = low(:, 4);
low_mpc_trq1 = low(:, 5);
low_mpc_trq2 = low(:, 6);
low_mpc_pwr = low(:, 7);

% Line width for increased thickness
lineWidth = 2;

% Create figures for high and low data
figure(1)

% High data
subplot(3,1,1);
scatter(1:numel(high_base_trq1), high_base_trq1, 'b', 'x', 'LineWidth', lineWidth);
hold on;
scatter(1:numel(high_mpc_trq1), high_mpc_trq1, 'r', 'o', 'LineWidth', lineWidth);
title('High Data: Trq1 Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,2);
scatter(1:numel(high_base_trq2), high_base_trq2, 'b', 'x', 'LineWidth', lineWidth);
hold on;
scatter(1:numel(high_mpc_trq2), high_mpc_trq2, 'r', 'o', 'LineWidth', lineWidth);
title('High Data: Trq2 Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,3);
scatter(1:numel(high_base_pwr), high_base_pwr, 'b', 'x', 'LineWidth', lineWidth);
hold on;
scatter(1:numel(high_mpc_pwr), high_mpc_pwr, 'r', 'o', 'LineWidth', lineWidth);
title('High Data: Power Comparison');
xlabel('Step');
ylabel('Power');
legend('Baseline', 'MPC');
grid on;
sgtitle('MPC SOC/step less than Baseline SOC/step') 

figure(2)

% Low data
subplot(3,1,1);
scatter(1:numel(low_base_trq1), low_base_trq1, 'b', 'x', 'LineWidth', lineWidth);
hold on;
scatter(1:numel(low_mpc_trq1), low_mpc_trq1, 'r', 'o', 'LineWidth', lineWidth);
title('Low Data: Trq1 Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,2);
scatter(1:numel(low_base_trq2), low_base_trq2, 'b', 'x', 'LineWidth', lineWidth);
hold on;
scatter(1:numel(low_mpc_trq2), low_mpc_trq2, 'r', 'o', 'LineWidth', lineWidth);
title('Low Data: Trq2 Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,3);
scatter(1:numel(low_base_pwr), low_base_pwr, 'b', 'x', 'LineWidth', lineWidth);
hold on;
scatter(1:numel(low_mpc_pwr), low_mpc_pwr, 'r', 'o', 'LineWidth', lineWidth);
title('Low Data: Power Comparison');
xlabel('Step');
ylabel('Power');
legend('Baseline', 'MPC');
grid on;
sgtitle('MPC SOC/step greater than Baseline SOC/step')