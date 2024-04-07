load("Optimised_with_delta_u_Analysis.mat")
full=load("/home/harsh/Documents/GitHub/Full_baseline.mat");
high_base=[];
low_base=[];
middle_base=[];

high_ham=[];
low_ham=[];
middle_ham=[];

high_trq_f=[];
high_trq_r=[];
high_pre_f=[];
high_pre_r=[];

middle_trq_f=[];
middle_trq_r=[];

low_trq_f=[];
low_trq_r=[];

low_flag=[];
high_flag=[];
middle_flag=[];

Trq_demand_high=zeros(10,1);
Trq_demand_low=zeros(10,1);
Trq_demand_middle=zeros(10,1);

for i=1:10
    ndx_h=Analysis.high(i,1); % ndx for high points
    ndx_l=Analysis.low(i,1); % ndx for low points
    ndx_m=Analysis.random(i,1); % ndx for middle points
    
    Trq_demand_high(i)=Analysis.high(i,2)+Analysis.high(i,3);
    Trq_demand_low(i)=Analysis.low(i,2)+Analysis.low(i,3);
    Trq_demand_middle(i)=Analysis.random(i,2)+Analysis.random(i,3);
    
    % High points
    high_base=[high_base; [ndx_h, full.out.Full_EM_pwr(ndx_h,:)]];
    high_trq_f=[high_trq_f; [ndx_h, full.out.Trq_vec_F(ndx_h,:)]];
    high_trq_r=[high_trq_r; [ndx_h, full.out.Trq_vec_R(ndx_h,:)]];
    high_pre_f=[high_pre_f; [ndx_h, full.out.Trq_Pre_F(ndx_h,:)]];
    high_pre_r=[high_pre_r; [ndx_h, full.out.Trq_Pre_R(ndx_h,:)]];
    high_ham=[high_ham; [ndx_h, full.out.H_fun(ndx_h,:)]];
    high_flag=[high_flag; [ndx_h, full.out.flag(ndx_h,:)]];
    
    % Low points
    low_ham=[low_ham; [ndx_l, full.out.H_fun(ndx_l,:)]];
    low_base=[low_base; [ndx_l, full.out.Full_EM_pwr(ndx_l,:)]];
    low_trq_f=[low_trq_f; [ndx_l, full.out.Trq_vec_F(ndx_l,:)]];
    low_trq_r=[low_trq_r; [ndx_l, full.out.Trq_vec_R(ndx_l,:)]];
    low_flag=[low_flag; [ndx_l, full.out.flag(ndx_l,:)]];
    
    % Middle points
    middle_base=[middle_base; [ndx_m, full.out.Full_EM_pwr(ndx_m,:)]];
    middle_trq_f=[middle_trq_f; [ndx_m, full.out.Trq_vec_F(ndx_m,:)]];
    middle_trq_r=[middle_trq_r; [ndx_m, full.out.Trq_vec_R(ndx_m,:)]];
    middle_ham=[middle_ham; [ndx_m, full.out.H_fun(ndx_m,:)]];
    middle_flag=[middle_flag; [ndx_m, full.out.flag(ndx_m,:)]];
end

Full_analysis.high=high_base;
Full_analysis.low=low_base;
Full_analysis.middle=middle_base;
save('Full_analysis.mat',"Full_analysis");

Ham_analysis.high=high_ham;
Ham_analysis.low=low_ham;
Ham_analysis.middle=middle_ham;
Ham_analysis.flag_high=high_flag;
Ham_analysis.flag_low=low_flag;
Ham_analysis.flag_middle=middle_flag;
save('Ham_analysis.mat',"Ham_analysis");

Trq_dist.high_F=high_trq_f;
Trq_dist.high_R=high_trq_r;

Trq_dist.pre_F=high_pre_f;
Trq_dist.pre_R=high_pre_r;

Trq_dist.middle_F=middle_trq_f;
Trq_dist.middle_R=middle_trq_r;

Trq_dist.low_F=low_trq_f;
Trq_dist.low_R=low_trq_r;

Trq_dist.demand_high=Trq_demand_high;
Trq_dist.demand_low=Trq_demand_low;
Trq_dist.demand_middle=Trq_demand_middle;

save("Trq_dist.mat","Trq_dist");
