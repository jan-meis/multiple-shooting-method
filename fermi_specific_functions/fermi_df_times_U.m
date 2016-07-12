function [ y ] = fermi_df_times_U( t, U)
temp_sol = evalin('base', 'temp_sol');
i = evalin('base', 'temp_int');
u_temp=temp_sol(i).evaluate(t);
y=[0, t; 6*((u_temp(1,1))^(1/2)) , 0];
y=y*(U.evaluate(t));
end

