close all
% Load baseline data
base = load("baseline.mat");
base_velocity = base.out.velocity;
base_Trqcmd_1 = base.out.Trqcmd(:,1);
base_Trqcmd_2 = base.out.Trqcmd(:,2);
base_TTrq = base_Trqcmd_1 + base_Trqcmd_2;
base_SOC = base.out.baseline_SOC;
base_pwr = base.out.base_pwr;

% Load MPC data
mpc = load("NMPC_ts200_P2sec_delta_u_feedback_blind.mat");
mpc_velocity = mpc.out.velocity;
mpc_Trqcmd_1 = mpc.out.Trqcmd(:,1);
mpc_Trqcmd_2 = mpc.out.Trqcmd(:,2);
mpc_TTrq = mpc_Trqcmd_1 + mpc_Trqcmd_2;
mpc_SOC = mpc.out.SOC;
mpc_pwr = mpc.out.mpc_pwr;
%base_pwr = mpc.out.min_Pwr;
% Calculate differences
diff_velocity = base_velocity - mpc_velocity;
diff_Trqcmd_1 = base_Trqcmd_1 - mpc_Trqcmd_1;
diff_Trqcmd_2 = base_Trqcmd_2 - mpc_Trqcmd_2;
diff_TTrq = base_TTrq - mpc_TTrq;

% Difference between step SOCs
base_step=step(base_SOC);
mpc_step=step(mpc_SOC);
diff_SOC = base_step - mpc_step;
L=length(diff_SOC);
POI=[];
for i=1:L
    if abs(diff_TTrq(i))<1e-02 && diff_TTrq(i)~=0
        POI=[POI;i, base_Trqcmd_1(i), base_Trqcmd_2(i), base_pwr(i), mpc_Trqcmd_1(i), mpc_Trqcmd_2(i), mpc_pwr(i), diff_SOC(i)];
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
    