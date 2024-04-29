close all
clear
% Load Analysis data
% Load MPC data
cases=["Optimised_Analysis.mat";            %1
"Optimised_with_delta_u_Analysis.mat";      %2
"Optimised_with_full_feedback_Analysis.mat"; %3
"Optimised_blind_Analysis.mat"              %4
    ];
ndx=4;
mpc = load(cases(ndx));
load(cases(ndx));
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
s1.DataTipTemplate.DataTipRows(3).Label = "eff";

z2=high(:,9);
s2=scatter(1:numel(high_mpc_trq1), high_mpc_trq1, z2, 'r', 'o', 'LineWidth', lineWidth);
s2.DataTipTemplate.DataTipRows(1).Label = "i";
s2.DataTipTemplate.DataTipRows(2).Label = "Trq";
s2.DataTipTemplate.DataTipRows(3).Label = "eff";
title('High Data: Trq front Comparison');
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
s3.DataTipTemplate.DataTipRows(3).Label = "eff";

z4=high(:,10);
scatter(1:numel(high_mpc_trq2), high_mpc_trq2, z4, 'r', 'o', 'LineWidth', lineWidth);
s4.DataTipTemplate.DataTipRows(1).Label = "i";
s4.DataTipTemplate.DataTipRows(2).Label = "Trq";
s4.DataTipTemplate.DataTipRows(3).Label = "eff";
title('High Data: Trq rear Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,3);
scatter(1:numel(high_base_pwr), high_base_pwr-high_mpc_pwr, 'b', 'x', 'LineWidth', lineWidth);
title('High Data: Power Comparison');
xlabel('Step');
ylabel('Power');
legend('y = Baseline - MPC Pwr');
grid on;
sgtitle('MPC Power less than Baseline Power') 

figure(2)

% Low data
subplot(3,1,1);
y1=low(:,11);
r1=scatter(1:numel(low_base_trq1), low_base_trq1, y1, 'b', 'x', 'LineWidth', lineWidth);
hold on;
r1.DataTipTemplate.DataTipRows(1).Label = "i";
r1.DataTipTemplate.DataTipRows(2).Label = "Trq";
r1.DataTipTemplate.DataTipRows(3).Label = "eff";

y2=low(:,9);
r2= scatter(1:numel(low_mpc_trq1), low_mpc_trq1, y2, 'r', 'o', 'LineWidth', lineWidth);
r2.DataTipTemplate.DataTipRows(1).Label = "i";
r2.DataTipTemplate.DataTipRows(2).Label = "Trq";
r2.DataTipTemplate.DataTipRows(3).Label = "eff";
title('Low Data: Trq front Comparison');
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
r3.DataTipTemplate.DataTipRows(3).Label = "eff";

y4=low(:,10);
r4=scatter(1:numel(low_mpc_trq2), low_mpc_trq2, y4, 'r', 'o', 'LineWidth', lineWidth);
r4.DataTipTemplate.DataTipRows(1).Label = "i";
r4.DataTipTemplate.DataTipRows(2).Label = "Trq";
r4.DataTipTemplate.DataTipRows(3).Label = "eff";
title('Low Data: Trq rear Comparison');
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
legend('y= MPC - Baseline Pwr');
grid on;
sgtitle('MPC Power greater than Baseline power')

%% Random Points
random = Analysis.random; % Use Analysis.random instead of high and low

% Extracting data from random structure
random_base_trq1 = random(:, 2);
random_base_trq2 = random(:, 3);
random_base_pwr = random(:, 4);
random_mpc_trq1 = random(:, 5);
random_mpc_trq2 = random(:, 6);
random_mpc_pwr = random(:, 7);

% Line width for increased thickness
lineWidth = 2;

% Create figures for random data
figure(3)

% Random data
subplot(3,1,1);
c=random(:,11);
d=scatter(1:numel(random_base_trq1), random_base_trq1, c, 'b', 'x', 'LineWidth', lineWidth);
hold on;
d.DataTipTemplate.DataTipRows(1).Label = "i";
d.DataTipTemplate.DataTipRows(2).Label = "Trq";
d.DataTipTemplate.DataTipRows(3).Label = "eff";

c2=random(:,9);
d2=scatter(1:numel(random_mpc_trq1), random_mpc_trq1, c2, 'r', 'o', 'LineWidth', lineWidth);
d2.DataTipTemplate.DataTipRows(1).Label = "i";
d2.DataTipTemplate.DataTipRows(2).Label = "Trq";
d2.DataTipTemplate.DataTipRows(3).Label = "eff";
title('Mid Data: Trq front Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,2);
c3=random(:,12);
d3=scatter(1:numel(random_base_trq2), random_base_trq2, c3, 'b', 'x', 'LineWidth', lineWidth);
hold on;
d3.DataTipTemplate.DataTipRows(1).Label = "i";
d3.DataTipTemplate.DataTipRows(2).Label = "Trq";
d3.DataTipTemplate.DataTipRows(3).Label = "eff";

c4=random(:,10);
d4=scatter(1:numel(random_mpc_trq2), random_mpc_trq2, c4, 'r', 'o', 'LineWidth', lineWidth);
d4.DataTipTemplate.DataTipRows(1).Label = "i";
d4.DataTipTemplate.DataTipRows(2).Label = "Trq";
d4.DataTipTemplate.DataTipRows(3).Label = "eff";
title('Mid Data: Trq rear Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(3,1,3);
scatter(1:numel(random_base_pwr), random_base_pwr-random_mpc_pwr, 'b', 'x', 'LineWidth', lineWidth);
title('Middle Data: Power Comparison');
xlabel('Step');
ylabel('Power');
legend('y = Baseline - MPC Pwr');
grid on;
sgtitle('MPC Power less than Baseline Power (middle)');