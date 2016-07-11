function [ y ] = DF(v, d, m, t, steps)
f = evalin('base', 'f');
df_times_U = evalin('base', 'df_times_U');
ivpSolver = evalin('base', 'ivpSolver');


B_a=[1, 0; 0, 0];
B_b=[0, 0; 1, 0];


y=zeros((m+1)*d, (m+1)*d);


for i=2:(m+1)
    y((i-2)*d+1:(i-1)*d , 1+(i-1)*d:i*d )=-eye(2);
end


y(  (m+1)*d-d+1:(m+1)*d, 1:d)=B_a;
y( (m+1)*d-d+1:(m+1)*d, (m+1)*d-d+1:(m+1)*d) = B_b;


for i=1:m
    u_temp=ivpSolver(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), f, steps);
    U_temp=explicitEulerForVariationEquation(t(1, i), t(1, i+1), eye(d), df_times_U, u_temp, steps);
    y((i-1)*d+1:(i)*d , 1+(i-1)*d:(i)*d )=U_temp.evaluate(t(1, i+1));
end
end

