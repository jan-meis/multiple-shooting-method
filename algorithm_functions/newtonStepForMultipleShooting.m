function [ y ] = newtonStepForMultipleShooting(v, d, r, m, t, steps)

y= v - (( ( DF(v, d, m, t, steps) )^(-1))*F(v, d, r, m, t, steps));

end

