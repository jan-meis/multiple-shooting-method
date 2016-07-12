function [ y ] = one_dim_example_f(t, u)
u_temp=u.evaluate(t);
y=u_temp*u_temp;
end

