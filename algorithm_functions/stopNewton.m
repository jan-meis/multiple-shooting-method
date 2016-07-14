function [ y ] = stopNewton(epsilon, ivpSolver, f, v, d, m, r, t)
temp_sol = evalin('base', 'temp_sol');
max=norm(r(v( (1-1)*d+1:1*d, 1), v( (m+1-1)*d+1:(m+1)*d, 1)));

for i=1:(m)
    if ( norm(temp_sol(i).evaluate(t(1, i+1))- v( (i)*d+1:(i+1)*d, 1)) > max)
        max =norm(temp_sol(i).evaluate(t(1, i+1))- v( (i)*d+1:(i+1)*d, 1));
    end
end

if (max > epsilon)
    y=false;
elseif (isnan(max))
    y=false;
else
    y=true;
end


end

