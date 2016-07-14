function [ y ] = other_f( t, u )
u_temp=u.evaluate(t);

y=[t*(u_temp(2,1)); 4*((u_temp(1,1))^(3/2))];

end

