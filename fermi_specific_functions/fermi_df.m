function [ y ] = fermi_df(t, u)
u_temp=u(t);
y=[0, t; 6*((u_temp(1,1))^(1/2)) , 0];
end

