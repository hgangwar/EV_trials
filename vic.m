base = load("baseline2.mat");
%base = load("baseline_wtp3.mat");
%base = load("baseline_us06.mat");

base_velocity = base.out.velocity;
base_Trqcmd_1 = base.out.Trqcmd(:,1);
base_Trqcmd_2 = base.out.Trqcmd(:,2);
base_TTrq= base_Trqcmd_1+base_Trqcmd_2;
base_decision= base_Trqcmd_1./base_TTrq;

cases=["Nominal_MPC_10ms.mat"                               %1
    "NMPC_mod.mat";                                         %2
    "NMPC_ts200_P2sec_delta_u_without_J2.mat";              %3
    "NMPC_ts200_P2sec_delta_u.mat";                         %4
    "NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init.mat";         %5
    "NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init_2.mat";       %6
    "NMPC_ts200_P2sec_delta_u_feedback.mat";                %7
    "NMPC_ts200_P2sec_delta_u_feedback_sqp.mat";            %8
    "NMPC_ts200_P2sec_delta_u_feedback_with_j2.mat";        %9
    "NMPC_ts200_P2sec_delta_u_feedback_blind.mat";          %10
    ];
ndx=1;
mpc = load(cases(ndx));

%mpc = load("NMPC_mod.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_without_J2.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init_2.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback_sqp.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback_with_j2.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback_blind.mat");

%mpc = load("NMPC_ts400_P4sec_delta_u_feedback_sqp_Pdriver.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback_blind_ebiased_wltp3.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback_blind_J1_J2_us06.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback_blind_wtp3.mat");

mpc_velocity = mpc.out.velocity;
mpc_Trqcmd_1 = mpc.out.Trqcmd(:,1);
mpc_Trqcmd_2 = mpc.out.Trqcmd(:,2);
mpc_TTrq=mpc_Trqcmd_1+mpc_Trqcmd_2;
mpc_decision = mpc_Trqcmd_1./mpc_TTrq;

base_SOC=base.out.SOC;
mpc_SOC = mpc.out.SOC;
SOC_used=60-base_SOC(end);
savings=mpc_SOC(end)-base_SOC(end);
percentage=(savings/SOC_used)*100;
disp(percentage)
step=1:247401;
line_width=5;
scatter(step,mpc_decision,line_width,'filled', 'r');
hold on;
scatter(step,base_decision,line_width,'b')
performance=[performance; [cases(ndx),percentage]];

