base = load("baseline.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_without_J2.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init_2.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_ts_sqp_leg_init.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback_sqp.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u.mat");
%mpc = load("NMPC_mod.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback_with_j2.mat");
%mpc = load("NMPC_ts200_P2sec_delta_u_feedback_blind.mat");
mpc = load("NMPC_ts200_P2sec_delta_u_feedback_blind_J1.mat");
base_SOC=base.out.baseline_SOC;
mpc_SOC = mpc.out.SOC;
SOC_used=60-base_SOC(end);
savings=mpc_SOC(end)-base_SOC(end);
percentage=(savings/SOC_used)*100;
disp(percentage)
step=1:247401;
figure(3)
scatter(step,mpc.out.prev_u, 'r');
%performance=[performance; (percentage)];n