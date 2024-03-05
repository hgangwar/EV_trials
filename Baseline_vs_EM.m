% Load baseline data
base = load("baseline.mat");
base_velocity = base.out.velocity;
base_Trqcmd_1 = base.out.Trqcmd(:,1);
base_Trqcmd_2 = base.out.Trqcmd(:,2);
base_TTrq= base_Trqcmd_1+base_Trqcmd_2;
base_decision= base_Trqcmd_1./base_TTrq;

base_SOC = base.out.baseline_SOC;

% Load MPC data
mpc = load("NMPC_ts200_P2sec.mat");
mpc_velocity = mpc.out.velocity;
mpc_Trqcmd_1 = mpc.out.Trqcmd(:,1);
mpc_Trqcmd_2 = mpc.out.Trqcmd(:,2);
mpc_TTrq=mpc_Trqcmd_1+mpc_Trqcmd_2;

mpc_SOC = mpc.out.SOC;
mpc_decision = mpc_Trqcmd_1./mpc_TTrq;
for i=1:247401
    if (base_TTrq(i)==0)
        base_decision(i)=0;
    end
    if (mpc_TTrq(i)==0)
        mpc_decision(i)=0;
    end
end

% Plot the data
figure(1)
% Plot velocity
subplot(3, 2, 1);
plot(mpc_velocity, 'r-');
hold on;
plot(base_velocity, 'b--');
title('Velocity');
legend('MPC', 'Baseline');

% Plot Trqcmd_1
subplot(3, 2, 2);
plot(mpc_Trqcmd_1, 'r-');
hold on;
plot(base_Trqcmd_1, 'b--');
title('Trqcmd 1');
legend('MPC', 'Baseline');

% Plot Trqcmd_2
subplot(3, 2, 3);
plot(mpc_Trqcmd_2, 'r-');
hold on;
plot(base_Trqcmd_2, 'b--');

title('Trqcmd 2');
legend('MPC', 'Baseline');

% Plot Total Torque
subplot(3, 2, 4);
plot(base_TTrq, 'b--');
hold on;
plot(mpc_TTrq, 'r-');
title('Total Torque');
legend('MPC', 'Baseline');

% Plot SOC
subplot(3, 2, 5);
plot(mpc_SOC, 'r-');
hold on;
plot(base_SOC, 'b--');
title('SOC');
legend('MPC', 'Baseline');

% Add labels and titles
xlabel('Time');
ylabel('Value');
sgtitle('Comparison of Baseline and MPC Data');


step=1:247401;
figure(2)
scatter(step,mpc_decision,'filled', 'r');
hold on;
scatter(step,base_decision,'filled','b')
title("Decision Variable")
%legend('MPC', 'Baseline');
