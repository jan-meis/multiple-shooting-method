function [ y ] = stopNewton(epsilon, ivpSolver, f, v, d, m, r, t)
max=norm(r(v, v( (1-1)*d+1:1*d, 1), v( (m+1-1)*d+1:(m+1)*d, 1), d, m));

for i=1:(m)
    erg_temp= ivpSolver(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), f, 300);
    if ( norm(erg_temp.lastVal()- v( (i)*d+1:(i+1)*d, 1)) > max)
        max =norm(erg_temp.lastVal()- v( (i)*d+1:(i+1)*d, 1));
    end
end

if (max > epsilon)
    y=false;
else
    y=true;
end

end

