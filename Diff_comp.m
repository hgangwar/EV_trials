close all
Data2 = load("eff_map.mat");
Data3 = load("Max_Torque_vs_EMSpeed.mat");
eff = Data2.eff;
torque = Data2.torque;
speed = Data2.speed;
TorqueVsSpeed = Data3.TorqueVsSpeed;

% Load baseline data
base = load("baseline.mat");
base_velocity = base.out.velocity;
base_Trqcmd_f = base.out.Trqcmd(:,1);
base_Trqcmd_r = base.out.Trqcmd(:,2);
base_TTrq = base_Trqcmd_f + base_Trqcmd_r;
base_SOC = base.out.baseline_SOC;
base_pwr = base.out.base_pwr;
base_EMspeed_f = base.out.EMspeed(:,1);
base_EMspeed_r = base.out.EMspeed(:,2);

% Load MPC data
mpc = load("NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init_2.mat");
mpc_velocity = mpc.out.velocity;
mpc_Trqcmd_f= mpc.out.Trqcmd(:,1);
mpc_Trqcmd_r = mpc.out.Trqcmd(:,2);
mpc_TTrq = mpc_Trqcmd_f + mpc_Trqcmd_r;
mpc_SOC = mpc.out.SOC;
mpc_pwr = mpc.out.mpc_pwr;
mpc_EMspeed_f = mpc.out.EMspeed(:,1);
mpc_EMspeed_r = mpc.out.EMspeed(:,2);

sim_len=length(mpc_SOC);

% Calculate efficiencies for mpc and baseline
for i= 1:sim_len
    %for mpc
    eta_f_mpc(i) = interp2(torque, speed, eff, min(abs(mpc_Trqcmd_f(i)) ,450),mpc_EMspeed_f(i));
    eta_r_mpc(i) = interp2(torque, speed, eff, min(abs(mpc_Trqcmd_r(i)) ,450),mpc_EMspeed_r(i));
    %for baseline
    eta_f_base(i) = interp2(torque, speed, eff, min(abs(base_Trqcmd_f(i)) ,450),base_EMspeed_f(i));
    eta_r_base(i) = interp2(torque, speed, eff, min(abs(base_Trqcmd_r(i)) ,450),base_EMspeed_r(i));
end
% Calculate differences
diff_velocity = base_velocity - mpc_velocity;
diff_Trqcmd_1 = base_Trqcmd_f - mpc_Trqcmd_f;
diff_Trqcmd_2 = base_Trqcmd_r - mpc_Trqcmd_r;
diff_TTrq = base_TTrq - mpc_TTrq;
diff_Pwr = base_pwr-mpc_pwr;

% Difference between step SOCs
%base_step=step(base_SOC);
%mpc_step=step(mpc_SOC);
%diff_SOC = base_step - mpc_step;
POI=[];
for i=1:sim_len
    if abs(diff_TTrq(i))<1e-02 && diff_TTrq(i)~=0
        POI=[POI;i, base_Trqcmd_f(i), base_Trqcmd_r(i), base_pwr(i), mpc_Trqcmd_f(i), mpc_Trqcmd_r(i), mpc_pwr(i), diff_Pwr(i), eta_f_mpc(i), eta_r_mpc(i), eta_f_base(i), eta_r_base(i),...
            base_EMspeed_f(i), base_EMspeed_r(i), mpc_EMspeed_f(i), mpc_EMspeed_r(i)];
    end
end

%Analysis=[diff_velocity, diff_Trqcmd_1, diff_Trqcmd_2, diff_TTrq, diff_SOC];
sorted_diff = sortrows(POI, 8);
low=sorted_diff(1:10,:);
high=sorted_diff(end-9:end,:);
Analysis.high=high;
Analysis.low=low;
save('Analysis.mat',"Analysis");

function x=step(y)
    prev=60;
    n=length(y);
    x=zeros(n,1);
    for i=1:n
        x(i)=prev-y(i);
        prev=y(i);
    end      
end
    