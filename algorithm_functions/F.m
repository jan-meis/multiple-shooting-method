function [ y ] = F(v, d, r, m, t, steps)
y=zeros(size(v, 1),1);
temp_sol = evalin('base', 'temp_sol');
for i=1:((size(v, 1)/d) - 1)
    y( (i-1)*d+1:i*d, 1) =  temp_sol(i).evaluate(t(1, i+1)) - v( (i)*d+1:(i+1)*d, 1);
end
i = (size(v, 1)/d);
y( (i-1)*d+1:i*d, 1) = r(v( ((1)-1)*d+1:(1)*d, 1), v( (i-1)*d+1:i*d, 1));

end

