function [ y ] = F(v, d, r, m, t)

y=zeros(size(v, 1),1);
for i=1:((size(v, 1)/d) - 1)
    u_temp=explicitEulerOrder1(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), @fermi_f, 200);
    y( (i-1)*d+1:i*d, 1) =  u_temp.evaluate(t(1, i+1)) - v( (i)*d+1:(i+1)*d, 1);
end
i = (size(v, 1)/d);
y( (i-1)*d+1:i*d, 1) = r(v, v( ((1)-1)*d+1:(1)*d, 1), v( ((i)-1)*d+1:(i)*d, 1),  d, m );

end

