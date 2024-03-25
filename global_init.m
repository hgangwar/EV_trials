
Data1=load("ftp75_5ms.mat");
load("ds_wltp3_5ms.mat");
Data2 = load("eff_map.mat");
Data3 = load("Max_Torque_vs_EMSpeed.mat");

custom_struct.ftp75_5ms = Data1.ftp75_5ms;
custom_struct.wltp3_5ms = wltp3_5ms;
custom_struct.eff = Data2.eff;
custom_struct.torque = Data2.torque;
custom_struct.speed = Data2.speed;
custom_struct.TorqueVsSpeed = Data3.TorqueVsSpeed;
Data_var=Simulink.Bus.createObject(custom_struct);

Data_bus=evalin("base",Data_var.busName);



