SOC_used=60-base_SOC(end);
savings=mpc_SOC(end)-base_SOC(end);
percentage=(savings/SOC_used)*100;
disp(percentage)