base = load("baseline.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_without_J2.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init_2.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init.mat");
mpc = load("NMPC_ts200_P2sec_delta_u_feedback.mat");
base_SOC=base.out.baseline_SOC;
mpc_SOC = mpc.out.SOC;
SOC_used=60-base_SOC(end);
savings=mpc_SOC(end)-base_SOC(end);
percentage=(savings/SOC_used)*100;
disp(percentage)
step=1:247401;
scatter(step,mpc.out.prev_u, 'r');