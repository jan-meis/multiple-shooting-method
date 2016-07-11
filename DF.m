function [ y ] = DF(v, d, m, t)

%B_a = sign(v(1,1))*diag(v( (1-1)*d+1:1*d, 1) );
%vielleicht B_a(2,2)=0;
B_a=[1, 0; 0, 0];

%B_b = sign(v( (m+1-1)*d+1, 1))*diag(v( (m+1-1)*d+1:(m+1)*d, 1));
%vielleicht B_b(2,2)=0;
B_b=[0, 0; 1, 0];

y=zeros((m+1)*d, (m+1)*d);


for i=2:(m+1)
    y((i-2)*d+1:(i-1)*d , 1+(i-1)*d:i*d )=-eye(2);
end


y(  (m+1)*d-d+1:(m+1)*d, 1:d)=B_a;
y( (m+1)*d-d+1:(m+1)*d, (m+1)*d-d+1:(m+1)*d) = B_b;


for i=1:m
    u_temp=explicitEulerOrder1(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), @fermi_f, 300);
    U_temp=explicitEulerForVariationEquation(t(1, i), t(1, i+1), eye(d), @fermi_df_times_U, u_temp, 300);
    y((i-1)*d+1:(i)*d , 1+(i-1)*d:(i)*d )=U_temp.evaluate(t(1, i+1));
end
end

