function [ y ] = generic_df_times_U(t, U)
temp_sol = evalin('base', 'temp_sol');
i = evalin('base', 'temp_int');
d = evalin('base', 'd');
f = evalin('base', 'f');
epsilon = evalin('base', 'numerical_dif_const');
u =temp_sol(i);

y=numericalJacobianOf_f( d, f, u, t, epsilon );
y=y*(U.evaluate(t));
end

