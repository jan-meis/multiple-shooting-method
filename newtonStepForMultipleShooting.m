function [ y ] = newtonStepForMultipleShooting(v, d, r, m, t)

y= v - (( ( DF(v, d, m, t) )^(-1))*F(v, d, r, m, t));

end

