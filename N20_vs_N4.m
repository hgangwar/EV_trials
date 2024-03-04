close all
% Load baseline data
base = load("mpc_main_n20.mat");
base_velocity = base.out.velocity;
base_Trqcmd_1 = base.out.Trqcmd(:,1);
base_Trqcmd_2 = base.out.Trqcmd(:,2);
base_TTrq = base_Trqcmd_1 + base_Trqcmd_2;
base_SOC = base.out.SOC_N20;

% Load MPC data
mpc = load("variable_model_fixed_MPC_10ms.mat");
mpc_velocity = mpc.out.velocity;
mpc_Trqcmd_1 = mpc.out.Trqcmd(:,1);
mpc_Trqcmd_2 = mpc.out.Trqcmd(:,2);
mpc_TTrq = mpc_Trqcmd_1 + mpc_Trqcmd_2;
mpc_SOC = mpc.out.SOC_Var;

% Calculate differences
diff_velocity = base_velocity - mpc_velocity;
diff_Trqcmd_1 = base_Trqcmd_1 - mpc_Trqcmd_1;
diff_Trqcmd_2 = base_Trqcmd_2 - mpc_Trqcmd_2;
diff_TTrq = base_TTrq - mpc_TTrq;

% Difference between step SOCs
base_step=step(base_SOC);
mpc_step=step(mpc_SOC);
diff_SOC = base_step - mpc_step;

Analysis=[diff_velocity, diff_Trqcmd_1, diff_Trqcmd_2, diff_TTrq, diff_SOC];
sorted_diff = sortrows(Analysis, 5);
low=sorted_diff(1:10,:);
high=sorted_diff(end-9:end,:);
% Plot the differences
figure;

% Plot difference in velocity
subplot(3, 2, 1);
plot(diff_velocity, 'Color', 'blue');
title('Velocity Difference');
xlabel('Time');
ylabel('Difference');
grid on;

% Plot difference in Trqcmd_1
subplot(3, 2, 2);
plot(diff_Trqcmd_1, 'Color', 'red');
title('Trqcmd 1 Difference');
xlabel('Time');
ylabel('Difference');
grid on;

% Plot difference in Trqcmd_2
subplot(3, 2, 3);
plot(diff_Trqcmd_2, 'Color', 'green');
title('Trqcmd 2 Difference');
xlabel('Time');
ylabel('Difference');
grid on;

% Plot difference in Total Torque
subplot(3, 2, 4);
plot(diff_TTrq, 'Color', 'magenta');
title('Total Torque Difference');
xlabel('Time');
ylabel('Difference');
grid on;

% Plot difference in SOC
subplot(3, 2, 5);
plot(diff_SOC, 'Color', 'cyan');
title('SOC Difference');
xlabel('Time');
ylabel('Difference');
grid on;

% Add labels and titles
sgtitle('Differences Between N=20 and N=4');

function x=step(y)
    prev=60;
    n=length(y);
    x=zeros(n,1);
    for i=1:n
        x(i)=prev-y(i);
        prev=y(i);
    end      
end
    