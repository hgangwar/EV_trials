close all
load("Full_analysis.mat")
load("Ham_analysis.mat")
load("Trq_dist.mat")
ndx = 1;

% High Points
Ham_high = Ham_analysis.high(ndx,2:end);
flag = Ham_analysis.flag_high(ndx,2:end) == 0;
Ham_feasible = Ham_high(flag);
Ham_infeasible = Ham_high(~flag);

Trq_f_high = 0.3012 * Trq_dist.high_F(ndx,2:end);
Trq_r_high = 0.3012 * Trq_dist.high_R(ndx,2:end);

% Low Points
Trq_f_low = 0.3012 * Trq_dist.low_F(ndx,2:end);
Trq_r_low = 0.3012 * Trq_dist.low_R(ndx,2:end);

% Middle Points
Trq_f_middle = 0.3012 * Trq_dist.middle_F(ndx,2:end);
Trq_r_middle = 0.3012 * Trq_dist.middle_R(ndx,2:end);

% Plot for High Points
figure;
subplot(4,1,1)
scatter(1:numel(Full_analysis.high(ndx,2:end)), Full_analysis.high(ndx,2:end));
title("Baseline Power Vector (High Points)")
xlabel('Step')
ylabel('Power (Watts)')
legend('Power (in Watts)');

subplot(4,1,2)
scatter(1:length(Ham_feasible), Ham_feasible,'green');
hold on 
scatter(1:length(Ham_infeasible), Ham_infeasible,'red');
title("Hamiltonian Function Vector (High Points)")
xlabel('Step')
ylabel('Hamiltonian Function Value')
legend('Feasible Points', 'Infeasible Points');

subplot(4,1,3)
scatter(1:numel(Trq_f_high), Trq_f_high,'yellow');
title("Trq Vector Distribution (Front)")
xlabel('Step')
ylabel('Torque')
legend('High Points');

subplot(4,1,4)
scatter(1:numel(Trq_r_high), Trq_r_high,'red');
title("Trq Vector Distribution (Rear)")
xlabel('Step')
ylabel('Torque')
legend('High Points');

sgtitle(['Optimization space for Trq, demand=',num2str(Trq_dist.demand_high(ndx))]);

% Plot for Low Points
figure;
subplot(4,1,1)
scatter(1:numel(Full_analysis.low(ndx,2:end)), Full_analysis.low(ndx,2:end));
title("Baseline Power Vector (Low Points)")
xlabel('Step')
ylabel('Power (Watts)')
legend('Power (in Watts)');

subplot(4,1,2)
scatter(1:numel(Ham_analysis.low(ndx,2:end)), Ham_analysis.low(ndx,2:end), 'green');
title("Hamiltonian Function Vector (Low Points)")
xlabel('Step')
ylabel('Hamiltonian Function Value')

subplot(4,1,3)
scatter(1:numel(Trq_f_low), Trq_f_low,'yellow');
title("Trq Vector Distribution (Front) (Low Points)")
xlabel('Step')
ylabel('Torque')

subplot(4,1,4)
scatter(1:numel(Trq_r_low), Trq_r_low,'red');
title("Trq Vector Distribution (Rear) (Low Points)")
xlabel('Step')
ylabel('Torque')

sgtitle(['Optimization space for Trq, demand=',num2str(Trq_dist.demand_low(ndx))]);

% Plot for Middle Points
figure;
subplot(4,1,1)
scatter(1:numel(Full_analysis.middle(ndx,2:end)), Full_analysis.middle(ndx,2:end));
title("Baseline Power Vector (Middle Points)")
xlabel('Step')
ylabel('Power (Watts)')
legend('Power (in Watts)');

subplot(4,1,2)
scatter(1:numel(Ham_analysis.middle(ndx,2:end)), Ham_analysis.middle(ndx,2:end),'green');
title("Hamiltonian Function Vector (Middle Points)")
xlabel('Step')
ylabel('Hamiltonian Function Value')

subplot(4,1,3)
scatter(1:numel(Trq_f_middle), Trq_f_middle,'yellow');
title("Trq Vector Distribution (Front) (Middle Points)")
xlabel('Step')
ylabel('Torque')

subplot(4,1,4)
scatter(1:numel(Trq_r_middle), Trq_r_middle,'red');
title("Trq Vector Distribution (Rear) (Middle Points)")
xlabel('Step')
ylabel('Torque')

sgtitle(['Optimization space for Trq, demand=',num2str(Trq_dist.demand_middle(ndx))]);
