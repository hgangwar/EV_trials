clc
clear
close all
load("Prediction.mat")
load("efficiencies.mat")
high_base=[];
low_base=[];

base = load("baseline.mat");
base_velocity = base.out.velocity;
base_Trqcmd_f = base.out.Trqcmd(:,1);
base_Trqcmd_r = base.out.Trqcmd(:,2);
base_TTrq = base_Trqcmd_f + base_Trqcmd_r;
base_pwr = base.out.base_pwr;
base_EMspeed_f = base.out.EMspeed(:,1);
base_EMspeed_r = base.out.EMspeed(:,2);

% Load MPC data
cases=["Nominal_MPC_10ms.mat"                               %1
    "NMPC_mod5.mat";                                        %2      
    "NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init.mat";         %3
    "NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init_2.mat";       %4
    "NMPC_ts200_P2sec_delta_u_feedback.mat";                %5      
    "NMPC_ts200_P2sec_delta_u_feedback_blind.mat";          %6
    ];
ndx=5;
mpc = load(cases(ndx));
mpc_velocity = mpc.out.velocity;
mpc_Trqcmd_f= mpc.out.Trqcmd(:,1);
mpc_Trqcmd_r = mpc.out.Trqcmd(:,2);
mpc_TTrq = mpc_Trqcmd_f + mpc_Trqcmd_r;
mpc_pwr = mpc.out.mpc_pwr;
mpc_EMspeed_f = mpc.out.EMspeed(:,1);
mpc_EMspeed_r = mpc.out.EMspeed(:,2);

high=zeros(10,12);
low=zeros(10,12);
for i=1:10
    ndx_h=Prediction.high(i,1); % ndx for high points
    ndx_l=Prediction.low(i,1); % ndx for low points
    high(i,:)=[ndx_h, mpc_Trqcmd_f(ndx_h), mpc_Trqcmd_r(ndx_h), base_Trqcmd_f(ndx_h),...
        base_Trqcmd_r(ndx_h), mpc_pwr(ndx_h), base_pwr(ndx_h), efficiencies.base(ndx_h,1),...
        efficiencies.base(ndx_h,2), efficiencies.mpc(ndx_h,1), efficiencies.mpc(ndx_h,2), Prediction.high(i,4)];
    low(i,:)=[ndx_l, mpc_Trqcmd_f(ndx_l), mpc_Trqcmd_r(ndx_l), base_Trqcmd_f(ndx_l),...
        base_Trqcmd_r(ndx_l), mpc_pwr(ndx_h), base_pwr(ndx_l), efficiencies.base(ndx_l,1),...
        efficiencies.base(ndx_l,2), efficiencies.mpc(ndx_l,1), efficiencies.mpc(ndx_l,2), Prediction.low(i,4)];
end

% Extracting data from high and low structures
high_base_trq1 = high(:, 4);
high_base_trq2 = high(:, 5);
high_base_pwr = high(:, 7);
high_mpc_trq1 = high(:, 2);
high_mpc_trq2 = high(:, 3);
high_mpc_pwr = high(:, 6);
high_obj_diff= high(:, 12);

low_base_trq1 = low(:, 4);
low_base_trq2 = low(:, 5);
low_base_pwr = low(:, 7);
low_mpc_trq1 = low(:, 2);
low_mpc_trq2 = low(:, 3);
low_mpc_pwr = low(:, 6);
low_obj_diff= low(:, 12);
% Line width for increased thickness
lineWidth = 2;

% Create figures for high and low data
figure(1)

% High data
subplot(4,1,1);
z=high(:,10);
s1=scatter(1:numel(high_base_trq1), high_base_trq1, z, 'b', 'x', 'LineWidth', lineWidth);
hold on;
s1.DataTipTemplate.DataTipRows(1).Label = "i";
s1.DataTipTemplate.DataTipRows(2).Label = "Trq";
s1.DataTipTemplate.DataTipRows(3).Label = "eff";

z2=high(:,8);
s2=scatter(1:numel(high_mpc_trq1), high_mpc_trq1, z2, 'r', 'o', 'LineWidth', lineWidth);
s2.DataTipTemplate.DataTipRows(1).Label = "i";
s2.DataTipTemplate.DataTipRows(2).Label = "Trq";
s2.DataTipTemplate.DataTipRows(3).Label = "eff";
title('High Data: Trq front Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(4,1,2);
z3=high(:,11);
s3=scatter(1:numel(high_base_trq2), high_base_trq2, z3, 'b', 'x', 'LineWidth', lineWidth);
hold on;
s3.DataTipTemplate.DataTipRows(1).Label = "i";
s3.DataTipTemplate.DataTipRows(2).Label = "Trq";
s3.DataTipTemplate.DataTipRows(3).Label = "eff";

z4=high(:,9);
scatter(1:numel(high_mpc_trq2), high_mpc_trq2, z4, 'r', 'o', 'LineWidth', lineWidth);
s4.DataTipTemplate.DataTipRows(1).Label = "i";
s4.DataTipTemplate.DataTipRows(2).Label = "Trq";
s4.DataTipTemplate.DataTipRows(3).Label = "eff";
title('High Data: Trq rear Comparison');
xlabel('Step');
ylabel('Torque');
legend('Baseline', 'MPC');
grid on;

subplot(4,1,3);
scatter(1:numel(high_base_pwr), high_base_pwr-high_mpc_pwr, 'b', 'x', 'LineWidth', lineWidth);
title('High Data: Power Comparison');
xlabel('Step');
ylabel('Power');
legend('y = Baseline - MPC Pwr');
grid on;

subplot(4,1,4);
scatter(1:numel(high_base_pwr), high_obj_diff, 'b', 'x', 'LineWidth', lineWidth);
title('High Data: Predicted power Comparison');
xlabel('Step');
ylabel('Power');
legend('y = Baseline - MPC Pwr');
grid on;
sgtitle('MPC Power less than Baseline Power') 

figure(2)

% Low data
subplot(3,1,1);
y1=low(:,10);
r1=scatter(1:numel(low_base_trq1), low_base_trq1, y1, 'b', 'x', 'LineWidth', lineWidth);
hold on;
r1.DataTipTemplate.DataTipRows(1).Label = "i";
r1.DataTipTemplate.DataTipRows(2).Label = "Trq";
r1.DataTipTemplate.DataTipRows(3).Label = "eff";

y2=low(:,8);
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
y3=low(:,11);
r3=scatter(1:numel(low_base_trq2), low_base_trq2, y3, 'b', 'x', 'LineWidth', lineWidth);
hold on;
r3.DataTipTemplate.DataTipRows(1).Label = "i";
r3.DataTipTemplate.DataTipRows(2).Label = "Trq";
r3.DataTipTemplate.DataTipRows(3).Label = "eff";

y4=low(:,9);
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
title('Low Data: Power Comparison');
xlabel('Step');
ylabel('Power');
legend('y= MPC - Baseline Pwr');
grid on;
sgtitle('MPC Power greater than Baseline power')

