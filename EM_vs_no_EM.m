% Load baseline data
base = load("NMPC_mod.mat");
base_velocity = base.out.velocity;
base_Trqcmd_1 = base.out.Trqcmd(:,1);
base_Trqcmd_2 = base.out.Trqcmd(:,2);
base_Uf = base.out.Uf;
base_Ur = base.out.Ur;
base_SOC = base.out.baseline_SOC;

% Load MPC data
mpc = load("C2_fixed_10ms.mat");
mpc_velocity = mpc.out.Velocity;
mpc_Trqcmd_1 = mpc.out.Trqcmd(:,1);
mpc_Trqcmd_2 = mpc.out.Trqcmd(:,2);
mpc_Uf = mpc.out.Uf;
mpc_Ur = mpc.out.Ur;
mpc_SOC = mpc.out.SOC_5ms;

% Plot the data
figure;

% Plot velocity
subplot(2, 3, 1);
plot(base_velocity, 'b--');
hold on;
plot(mpc_velocity, 'r-');
title('Velocity');
legend('Baseline', 'MPC');

% Plot Trqcmd_1
subplot(2, 3, 2);
plot(base_Trqcmd_1, 'b--');
hold on;
plot(mpc_Trqcmd_1, 'r-');
title('Trqcmd_1');
legend('Baseline', 'MPC');

% Plot Trqcmd_2
subplot(2, 3, 3);
plot(base_Trqcmd_2, 'b--');
hold on;
plot(mpc_Trqcmd_2, 'r-');
title('Trqcmd_2');
legend('Baseline', 'MPC');

% Plot Uf
subplot(2, 3, 4);
plot(base_Uf, 'b--');
hold on;
plot(mpc_Uf, 'r-');
title('Uf');
legend('Baseline', 'MPC');

% Plot Ur
subplot(2, 3, 5);
plot(base_Ur, 'b--');
hold on;
plot(mpc_Ur, 'r-');
title('Ur');
legend('Baseline', 'MPC');

% Plot SOC
subplot(2, 3, 6);
plot(base_SOC, 'b--');
hold on;
plot(mpc_SOC, 'r-');
title('SOC');
legend('Baseline', 'MPC');
