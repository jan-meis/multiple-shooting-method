function [ y ] = newtonStepForMultipleShooting(v, d, r, m, t, steps)
F_temp_start=F(v, d, r, m, t, steps);
stopping_cond_epsilon=evalin('base', 'stopping_cond_epsilon');
f=evalin('base', 'f');
ivpSolver=evalin('base', 'ivpSolver');

if (max(abs(F_temp_start)) < stopping_cond_epsilon)
    assignin('base', 'stopNewtonBool', true);
    y=v;
    return;
end

p=F_temp_start / norm(F_temp_start);
DF_temp = DF(v, d, m, t, steps);
DF_up_minus_one_temp=( DF_temp )^(-1);

m_num = transpose(p)*F_temp_start;

c=0.75;
tau=0.75;
te=-c*m_num;
a=norm(F_temp_start)*4/3;

F_temp_new = F_temp_start*a;




while(true)
    a=a*tau;
    F_temp = F_temp_new;
    y = v - (DF_up_minus_one_temp*(p*a));
    
    temp_sol={};
    for i=1:(m)
        erg_temp= ivpSolver(t(1, i), t(1, i+1), y( (i-1)*d+1:i*d, 1), f, steps);
        temp_sol=[temp_sol; erg_temp];
    end
    assignin('base', 'temp_sol', temp_sol);
    
    F_temp_new = F(y, d, r, m, t, steps);
    
    if (norm(F_temp_start) - norm(F_temp_new) >= te*a)
        break;
    end
end



end

