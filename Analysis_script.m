close all
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
z=high(:,11);
s1=scatter(1:numel(high_base_trq1), high_base_trq1, z, 'b', 'x', 'LineWidth', lineWidth);
hold on;
s1.DataTipTemplate.DataTipRows(1).Label = "i";
s1.DataTipTemplate.DataTipRows(2).Label = "Trq";
s1.DataTipTemplate.DataTipRows(3).Label = "e";

z2=high(:,9);
s2=scatter(1:numel(high_mpc_trq1), high_mpc_trq1, z2, 'r', 'o', 'LineWidth', lineWidth);
s2.DataTipTemplate.DataTipRows(1).Label = "i";
s2.DataTipTemplate.DataTipRows(2).Label = "Trq";
s2.DataTipTemplate.DataTipRows(3).Label = "e";
title('High Data: Trq1 Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,2);
z3=high(:,12);
s3=scatter(1:numel(high_base_trq2), high_base_trq2, z3, 'b', 'x', 'LineWidth', lineWidth);
hold on;
s3.DataTipTemplate.DataTipRows(1).Label = "i";
s3.DataTipTemplate.DataTipRows(2).Label = "Trq";
s3.DataTipTemplate.DataTipRows(3).Label = "e";

z4=high(:,10);
scatter(1:numel(high_mpc_trq2), high_mpc_trq2, z4, 'r', 'o', 'LineWidth', lineWidth);
s4.DataTipTemplate.DataTipRows(1).Label = "i";
s4.DataTipTemplate.DataTipRows(2).Label = "Trq";
s4.DataTipTemplate.DataTipRows(3).Label = "e";
title('High Data: Trq2 Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,3);
scatter(1:numel(high_base_pwr), high_base_pwr-high_mpc_pwr, 'b', 'x', 'LineWidth', lineWidth);
title('High Data: Power Comparison');
xlabel('Step');
ylabel('Power');
legend('Baseline - MPC Pwr');
grid on;
sgtitle('MPC SOC/step less than Baseline SOC/step') 

figure(2)

% Low data
subplot(3,1,1);
y1=low(:,11);
r1=scatter(1:numel(low_base_trq1), low_base_trq1, y1, 'b', 'x', 'LineWidth', lineWidth);
hold on;
r1.DataTipTemplate.DataTipRows(1).Label = "i";
r1.DataTipTemplate.DataTipRows(2).Label = "Trq";
r1.DataTipTemplate.DataTipRows(3).Label = "e";

y2=low(:,9);
r2= scatter(1:numel(low_mpc_trq1), low_mpc_trq1, y2, 'r', 'o', 'LineWidth', lineWidth);
r2.DataTipTemplate.DataTipRows(1).Label = "i";
r2.DataTipTemplate.DataTipRows(2).Label = "Trq";
r2.DataTipTemplate.DataTipRows(3).Label = "e";
title('Low Data: Trq1 Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,2);
y3=low(:,12);
r3=scatter(1:numel(low_base_trq2), low_base_trq2, y3, 'b', 'x', 'LineWidth', lineWidth);
hold on;
r3.DataTipTemplate.DataTipRows(1).Label = "i";
r3.DataTipTemplate.DataTipRows(2).Label = "Trq";
r3.DataTipTemplate.DataTipRows(3).Label = "e";

y4=low(:,10);
r4=scatter(1:numel(low_mpc_trq2), low_mpc_trq2, y4, 'r', 'o', 'LineWidth', lineWidth);
r4.DataTipTemplate.DataTipRows(1).Label = "i";
r4.DataTipTemplate.DataTipRows(2).Label = "Trq";
r4.DataTipTemplate.DataTipRows(3).Label = "e";
title('Low Data: Trq2 Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,3);
scatter(1:numel(low_mpc_pwr), low_mpc_pwr-low_base_pwr, 'r', 'o', 'LineWidth', lineWidth);
%scatter(1:numel(low_base_pwr), low_base_pwr, 'b', 'x', 'LineWidth', lineWidth);
%hold on;
%scatter(1:numel(low_mpc_pwr), low_mpc_pwr, 'r', 'o', 'LineWidth', lineWidth);
title('Low Data: Power Comparison');
xlabel('Step');
ylabel('Power');
%legend('Baseline', 'MPC');
legend('MPC - Baseline Pwr');
grid on;
sgtitle('MPC SOC/step greater than Baseline SOC/step')
