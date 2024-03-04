% Load data
%data = load("pwr_comp.mat");
data=load("NMPC_mod4.mat");
baseline_pwr = m_data.out.min_Pwr;
%mpc_pwr = m_data.out.mpc_pwr*0.3012; % Adjusted MPC power for comparison
mpc_pwr = data.out.mpc_pwr;
true_pwr = sum(data.out.real_pwr, 2);
%true_pwr= true_pwr(137:end);
x=data.out.flag;
a = unique(x);
out = [a,histc(x(:),a)];
%[N,edges] = histcounts(m_data.out.flag);

% Plot power comparison
figure;
% Plot Baseline Power vs True Power
subplot(3, 1, 1);
plot(mpc_pwr-baseline_pwr, 'r', 'LineWidth', 2); hold on;
%plot(baseline_pwr, 'b', 'LineWidth', 2);
xlabel('Time');
ylabel('Power');
title('MPC Power vs Baseline Power');
%legend('MPC Power', 'Baseline Power');
grid on;

% Plot MPC Power vs True Power
subplot(3, 1, 2);
plot(mpc_pwr, 'r', 'LineWidth', 2);
hold on;
plot(true_pwr, 'g', 'LineWidth', 2);
xlabel('Time');
ylabel('Power');
title('MPC Power vs True Power');
legend('MPC Power', 'True Power');
grid on;

subplot(3, 1, 3);
plot(baseline_pwr, 'b', 'LineWidth', 2); hold on;
plot(true_pwr, 'g', 'LineWidth', 2);
xlabel('Time');
ylabel('Power');
title('Baseline Power vs True Power');
legend('Baseline Power', 'True Power');
grid on;
