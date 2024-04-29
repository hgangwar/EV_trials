close all
load("Full_analysis.mat")
load("Ham_analysis.mat")
load("Trq_dist.mat")
ndx=5;
Ham_high=Ham_analysis.high(ndx,2:end);
flag=Ham_analysis.flag_high(ndx,2:end)==0;
Ham_feasible=Ham_high(flag);
Ham_infeasible=Ham_high(~flag);

Trq_f=0.3012*Trq_dist.high_F(ndx,2:end);
Trq_r=0.3012*Trq_dist.high_R(ndx,2:end);
step=1:201;
subplot(4,1,1)
scatter(step, Full_analysis.high(ndx,2:end));
title("Baseline Power Vector")
legend('Power (in Watts)');
subplot(4,1,2)
scatter(1:length(Ham_feasible), Ham_feasible,'green');
hold on 
scatter(1:length(Ham_infeasible), Ham_infeasible,'red');
title("Hamiltonina Function Vector")
legend('Hamiltonian function value');
subplot(4,1,3)
scatter(step, Trq_f,'yellow');
title("Trq Vector Distribution")
legend('Trq Vector Front');
subplot(4,1,4)
scatter(step, Trq_r,'red');
title("Trq Vector Distribution")
legend("Trq Vector Rear")
sgtitle(['Optimisation space, Trq for demand=',num2str(Trq_dist.demand_high(ndx))]);
%legend('Trq f','Trq r');

