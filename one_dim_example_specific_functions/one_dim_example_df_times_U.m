function [ y ] = one_dim_example_df_times_U( t, U)
temp_sol = evalin('base', 'temp_sol');
i = evalin('base', 'temp_int');
u_temp=temp_sol(i).evaluate(t);

y=2*u_temp*(U.evaluate(t));

end

