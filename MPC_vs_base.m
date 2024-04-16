close all
clear
% Load baseline data
base = load("baseline.mat");
base_pwr = base.out.base_pwr;
base_velocity = base.out.velocity;
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
mpc_pwr = mpc.out.mpc_pwr;

% Analysis
sim_len=length(base_pwr);
MPC_Obj=zeros(sim_len,1);
Base_Obj=zeros(sim_len,1);
diff_velocity=abs(base_velocity-mpc_velocity);
for i=1:sim_len-10
    Temp=sum(mpc_pwr(i:i+10));
    if (diff_velocity(i)<1e-2 && ~isnan(mpc_pwr(i)) && ~isnan(base_pwr(i)))
        MPC_Obj(i)=sum(mpc_pwr(i:i+10));
        Base_Obj(i)=sum(base_pwr(i:i+10));
    end
end

for i=1:sim_len-10
    if(isnan(MPC_Obj(i)))
        Base_Obj(i)=0;
        MPC_Obj(i)=0;
    end
end 
treasure=[];
for i=1:sim_len-10
    if(MPC_Obj(i)<Base_Obj(i) && mpc_pwr(i)>base_pwr(i))
        treasure=[treasure; i];
    end
end 
Vector=[(1:sim_len)', Base_Obj,   MPC_Obj, Base_Obj-MPC_Obj;];
Vector=Vector(treasure,:);
sorted_Vector=sortrows(Vector,4);
low=sorted_Vector(1:10,:);
high=sorted_Vector(end-9:end,:);
Prediction.high=high;
Prediction.low=low;
save("Prediction.mat","Prediction");
