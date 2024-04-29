% Load baseline data
base = load("baseline.mat");
base_velocity = base.out.velocity;
base_Trqcmd_1 = base.out.Trqcmd(:,1);
base_Trqcmd_2 = base.out.Trqcmd(:,2);
base_TTrq= base_Trqcmd_1+base_Trqcmd_2;

base_SOC = base.out.baseline_SOC;

% Load MPC data
mpc = load("variable_model_fixed_MPC_10ms.mat");
mpc_velocity = mpc.out.velocity;
mpc_Trqcmd_1 = mpc.out.Trqcmd(:,1);
mpc_Trqcmd_2 = mpc.out.Trqcmd(:,2);
mpc_TTrq=mpc_Trqcmd_1+mpc_Trqcmd_2;
mpc_SOC = mpc.out.SOC_Var;


% Plot the data
figure;

% Plot velocity
subplot(3, 2, 1);
plot(mpc_velocity, 'r-');
hold on;
plot(base_velocity, 'b--');
title('Velocity');
legend('Baseline', 'MPC');

% Plot Trqcmd_1
subplot(3, 2, 2);
plot(mpc_Trqcmd_1, 'r-');
hold on;
plot(base_Trqcmd_1, 'b--');
title('Trqcmd 1');
legend('Baseline', 'MPC');

% Plot Trqcmd_2
subplot(3, 2, 3);
plot(mpc_Trqcmd_2, 'r-');
hold on;
plot(base_Trqcmd_2, 'b--');

title('Trqcmd 2');
legend('Baseline', 'MPC');

% Plot Total Torque
subplot(3, 2, 4);
plot(base_TTrq, 'b--');
hold on;
plot(mpc_TTrq, 'r-');
title('Total Torque');
legend('Baseline', 'MPC');

% Plot SOC
subplot(3, 2, 5);
plot(mpc_SOC, 'r-');
hold on;
plot(base_SOC, 'b--');
title('SOC');
legend('Baseline', 'MPC');

% Add labels and titles
xlabel('Time');
ylabel('Value');
sgtitle('Comparison of Baseline and MPC Data');