function [u_opt, U_f,U_r,min_Pwr, flag] = EVNMPC_u_feedback(req_data, current_timestep,SOC, v_curr,Torque_demand, EMspeed, prev_u)
    %% Extrinsic function used by Nonlinear MPC Block
    % Initializing U vector
    N=10;
    Ts=2e0-1;    
    % Using motor speed as decision variable
    if Torque_demand>0
        u0 = repmat(0.2,1,N);
    else
        u0 = repmat(0.8,1,N);
    end
    LB = zeros(1,N);
    UB = ones(1,N);

    % Motor speed
    Em1=EMspeed(1,1);
    Em2=EMspeed(2,1);

    %% Vehicle constants
    veh.M = 1623;           %Vehicle Mass 
    veh.R_whl = 0.327;      %Wheel effective radius
    veh.Crr = 0.012;        %Coefficient of friction
    veh.Cd = 0.389;         %Air drag coeficient
    veh.rho = 1.202;        %Air density, batt_V, batt_C
    veh.A = 2.27;           %Surface area car
    veh.f_ratio = 3.32;     %final gear ratio
    %veh.dmp_cnst= 100;      %Damping constant of drive shaft
    %veh.spring_const= 5000; %Spring constrant of drive shaft
    veh.mot_inertia= 0.01;      %Motor inertia
    veh.h = 0.3;
    veh.b = 1.7;
    veh.a = 1.09;
    veh.axle_diff_ratio=3.32;
    veh.charge_max=3.153;
    %% Velocity Reference Vector
    v_ref=zeros(N,1);
    j=Ts/5e-04;      
    len=size(req_data.wltp3_5ms,1);
    for i=1:N
        if(j*i<len)
            v_ref(i)=req_data.wltp3_5ms(current_timestep+(j*i),1);
        end
    end

    %% Wheel torque to EM torque
    EMtrq_demand=0.3012*Torque_demand;

    %% Loading effeciency map
    info.eff = req_data.eff;
    info.torque = req_data.torque;
    info.speed = req_data.speed;
    
    %% Torque limit data
    info.torque_limit=req_data.TorqueVsSpeed;
    COST = @(u) EVObjectiveFCN(u, N, Ts, v_curr, v_ref, veh, prev_u(1),info);
    CONSTRAINTS = @(u) EVConstraintFCN(SOC,u, N,Ts,veh,v_curr,v_ref, info);
    options = optimoptions('fmincon','Algorithm','sqp','Display','iter');
    if (Torque_demand==0)
        U_f=0;
        U_r=0;
        min_Pwr=0;
        flag=-3;
        u_opt=u0;
        return
    end
    [uopt,~,flag,~]= fmincon(COST,u0,[],[],[],[],LB,UB,CONSTRAINTS,options);
    EM_f=uopt(1)*EMtrq_demand;
    EM_r=EMtrq_demand-EM_f;
    U_f=uopt(1)*Torque_demand;
    U_r=Torque_demand-U_f;
    u_opt=uopt;
    % Calculating eta_f & eta_r
    if (Torque_demand >= 0)
        eta_f = interp2(info.torque,info.speed,info.eff,min(EM_f,450),Em1);
        eta_r = interp2(info.torque,info.speed,info.eff,min(EM_r,450),Em2);
        min_Pwr=(((EM_f*Em1)/(0.01*eta_f)) + ((EM_r*Em2)/(0.01*eta_r)))/0.98;
    else
        eta_f = interp2(info.torque,info.speed,info.eff,min(abs(EM_f),450),Em1);
        eta_r = interp2(info.torque,info.speed,info.eff,min(abs(EM_r),450),Em2);
        min_Pwr=(((EM_f*Em1)*(0.01*eta_f)) + ((EM_r*Em2)*(0.01*eta_r)))*0.98;
    end
    
end

function J = EVObjectiveFCN(u, N, Ts, v_curr, v_ref, veh, prev_u, info)
    v_k = v_curr;
    J = 0;
    % For initial condition
    % Calculating resistance forces
    F_aero = (veh.rho*veh.A*veh.Cd*(v_k^2))/2;
    F_rr = veh.M*9.81*veh.Crr;
     
    % Calculating current torque demand
    F_trac = F_aero + F_rr + veh.M*(v_ref(1) - v_k)/Ts;
    torque_demand = F_trac*veh.R_whl;
    
    for i=1:N
        % Calculating eta_f & eta_r
        %% Wheel torque to EM torque
        EMtrq_demand=0.3012*torque_demand;
        EM_sp = abs(v_k*veh.axle_diff_ratio/veh.R_whl);
        EM_sp=min(1675,EM_sp);
        if (torque_demand >= 0)
            eta_f = interp2(info.torque,info.speed,info.eff,u(i)*min(EMtrq_demand,450),EM_sp);
            eta_r = interp2(info.torque,info.speed,info.eff,(1-u(i))*min(EMtrq_demand,450),EM_sp);
        else
            eta_f = interp2(info.torque,info.speed,info.eff,u(i)*min(abs(EMtrq_demand),450),EM_sp);
            eta_r = interp2(info.torque,info.speed,info.eff,(1-u(i))*min(abs(EMtrq_demand),450),EM_sp);
        end
        %Calculating 
        % penalise excess power
        if (torque_demand >= 0)
            power_gen = ((u(i)*EMtrq_demand*EM_sp)/(0.01*eta_f)) + (((1-u(i))*EMtrq_demand*EM_sp)/(0.01*eta_r));
            power_ref = F_trac*v_k;
        else
            power_gen = abs(((u(i)*EMtrq_demand*EM_sp)*(0.01*eta_f)) + (((1-u(i))*EMtrq_demand*EM_sp)*(0.01*eta_r)));
            power_ref = abs(F_trac*v_k);
        end
        J1 = (power_ref - power_gen)'*1*(power_ref - power_gen);
        %J2 =  abs(((prev_EM1-u(2,i))/Ts)*veh.mot_inertia)+abs(((prev_EM2-u(3,i))/Ts)*veh.mot_inertia);
        %if i==1
        %    delta_u=abs(prev_u-u(i));
        %else
        %    delta_u=abs(u(i-1)-u(i));
        %end
        %J2=delta_u*1e02/Ts;
        %J = J + J1 +J2;            
        J = J + J1;
        
        
        % Calculating resistance forces
        F_aero = (veh.rho*veh.A*veh.Cd*(v_k^2))/2;
        F_rr = (veh.M*9.81*veh.Crr);

        % state dynamics
        v_k_next = v_k + ((torque_demand/(veh.M*veh.R_whl))*veh.f_ratio - F_aero/veh.M - F_rr/veh.M)*Ts;

        % Calculating the next torque demand
        % Assuming  
        F_trac = F_aero + F_rr + veh.M*(v_ref(i) - v_k_next)/Ts;
        next_torque_demand = F_trac*veh.R_whl;

        % Updating variables
        torque_demand = next_torque_demand/veh.f_ratio;
        v_k = v_k_next;
    end
end

%%
function [c,ceq]=EVConstraintFCN(SOC,u,N,Ts,veh,v_k,v_ref, info)
    % split :- 1 -> Front motor
    % split :- 0 -> Rear motor
    
    % calculate curr torque and torque vec
    num_of_constraints_per_stage=6;
    total_num_cosntraints=N*num_of_constraints_per_stage;
    c=zeros(total_num_cosntraints,1);
    x=SOC;  %state 
    E_batt=1e09;  %%Battery constant
    batt_max=.99;
    batt_min=0.4;
    for i=1:N
        F_aero = (veh.rho*veh.A*veh.Cd*(v_k^2))/2;
        F_rr = veh.M*9.81*veh.Crr;
        F_trac = F_aero + F_rr + veh.M*(v_ref(i) - v_k)/Ts;
        torque_demand = F_trac*veh.R_whl;
        EMtrq_demand=0.3012*torque_demand;
        EM_sp = abs(v_k*veh.axle_diff_ratio/veh.R_whl);
        EM_sp=min(1675,EM_sp);
        % Calculating eta_f & eta_r
        if (torque_demand > 0)
            eta_f = interp2(info.torque,info.speed,info.eff,u(i)*min(EMtrq_demand,450),EM_sp);
            eta_r = interp2(info.torque,info.speed,info.eff,(1-u(1,i))*min(EMtrq_demand,450),EM_sp);
        else
            eta_f = interp2(info.torque,info.speed,info.eff,u(1,i)*min(abs(EMtrq_demand),450),EM_sp);
            eta_r = interp2(info.torque,info.speed,info.eff,(1-u(1,i))*min(abs(EMtrq_demand),450),EM_sp);
        end
        if (torque_demand > 0)
            power_gen = ((u(i)*EMtrq_demand*EM_sp)/(0.01*eta_f)) + (((1-u(i))*EMtrq_demand*EM_sp)/(0.01*eta_r));
            x=x-(power_gen/E_batt);
        else
            power_gen = abs(((u(i)*EMtrq_demand*EM_sp)*(0.01*eta_f)) + (((1-u(i))*EMtrq_demand*EM_sp)*(0.01*eta_r)));
            x=x-(power_gen/E_batt);
        end
        % battery discharge constraints
        c((num_of_constraints_per_stage*(i-1))+1)=batt_min-x;
        c((num_of_constraints_per_stage*(i-1))+2)=x-batt_max;
        
        %for motor 1
        torque_max = interp1(info.torque_limit(:,1),info.torque_limit(:,2),EM_sp);
        torque_min = -torque_max;
        c((num_of_constraints_per_stage*(i-1))+3)=EMtrq_demand-(u(i)*EMtrq_demand);
        c((num_of_constraints_per_stage*(i-1))+4)=(u(i)*EMtrq_demand)-torque_max;
        %for motor 2
        c((num_of_constraints_per_stage*(i-1))+5)=torque_min-((1-u(i))*EMtrq_demand);
        c((num_of_constraints_per_stage*(i-1))+6)=((1-u(i))*EMtrq_demand)-torque_max;

       v_k = v_k + ((F_trac - F_aero - F_rr)/veh.M)*Ts;
    end
    ceq=[];  
end