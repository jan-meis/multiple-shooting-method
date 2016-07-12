function [ y ] = DF(v, d, m, t, steps)
df_times_U = evalin('base', 'df_times_U');
ivpSolver = evalin('base', 'ivpSolver');
r = evalin('base', 'r');
B_a_temp= evalin('base', 'B_a');
B_b_temp= evalin('base', 'B_b');


B_a=B_a_temp(r, v( (1-1)*d+1:1*d, 1));
B_b=B_b_temp(r, v( (m+1-1)*d+1:(m+1)*d, 1));


y=zeros((m+1)*d, (m+1)*d);


for i=2:(m+1)
    y((i-2)*d+1:(i-1)*d , 1+(i-1)*d:i*d )=-eye(2);
end


y(  (m+1)*d-d+1:(m+1)*d, 1:d)=B_a;
y( (m+1)*d-d+1:(m+1)*d, (m+1)*d-d+1:(m+1)*d) = B_b;


for i=1:m
    assignin('base', 'temp_int', i)
    U_temp=ivpSolver(t(1, i), t(1, i+1), eye(d), df_times_U, steps);
    y((i-1)*d+1:(i)*d , 1+(i-1)*d:(i)*d )=U_temp.evaluate(t(1, i+1));
end
end

