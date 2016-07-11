function [ y ] = fermi_df_times_U( t, U)
u=evalin('base', 'temp');

u_temp=u.evaluate(t);
y=[0, t; 6*((u_temp(1,1))^(1/2)) , 0];
y=y*(U.evaluate(t));
end

