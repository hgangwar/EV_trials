% Load baseline data
base = load("baseline.mat");
base_velocity = base.out.velocity;
base_EMspeed_1 = base.out.EMspeed(:,1);
base_EMspeed_2 = base.out.EMspeed(:,2);
base_Trqcmd_1 = base.out.Trqcmd(:,1);
base_Trqcmd_2 = base.out.Trqcmd(:,2);
base_Uf = base.out.Uf;
base_Ur = base.out.Ur;
base_SOC = base.out.baseline_SOC;

% Load MPC data
mpc = load("main_N_6.mat");
mpc_velocity = mpc.out.velocity;
mpc_EMspeed_1 = mpc.out.EMspeed(:,1);
mpc_EMspeed_2 = mpc.out.EMspeed(:,2);
mpc_Trqcmd_1 = mpc.out.Trqcmd(:,1);
t = mpc.out.Trqcmd(:,2);
mpc_Uf = mpc.out.Uf;
mpc_Ur = mpc.out.Ur;
mpc_SOC = mpc.out.SOC_Var;

% Plot the data
figure;

% Plot velocity
subplot(2, 4, 1);
plot(base_velocity, 'b--');
hold on;
plot(mpc_velocity, 'r-');
title('Velocity');
legend('Baseline', 'MPC');

% Plot EMspeed_1
subplot(2, 4, 2);
plot(base_EMspeed_1, 'b--');
hold on;
plot(mpc_EMspeed_1, 'r-');
title('EMspeed_1');
legend('Baseline', 'MPC');

% Plot EMspeed_2
subplot(2, 4, 3);
plot(base_EMspeed_2, 'b--');
hold on;
plot(mpc_EMspeed_2, 'r-');
title('EMspeed_2');
legend('Baseline', 'MPC');

% Plot Trqcmd_1
subplot(2, 4, 4);
plot(base_Trqcmd_1, 'b--');
hold on;
plot(mpc_Trqcmd_1, 'r-');
title('Trqcmd_1');
legend('Baseline', 'MPC');

% Plot Trqcmd_2
subplot(2, 4, 5);
plot(base_Trqcmd_2, 'b--');
hold on;
plot(mpc_Trqcmd_2, 'r-');
title('Trqcmd_2');
legend('Baseline', 'MPC');

% Plot Uf
subplot(2, 4, 6);
plot(base_Uf, 'b--');
hold on;
plot(mpc_Uf, 'r-');
title('Uf');
legend('Baseline', 'MPC');

% Plot Ur
subplot(2, 4, 7);
plot(base_Ur, 'b--');
hold on;
plot(mpc_Ur, 'r-');
title('Ur');
legend('Baseline', 'MPC');

% Plot SOC
subplot(2, 4, 8);
plot(base_SOC, 'b--');
hold on;
plot(mpc_SOC, 'r-');
title('SOC');
legend('Baseline', 'MPC');
