function [ y ] = generic_B_a( r, vec )
d=evalin('base', 'd');
epsilon=evalin('base', 'numerical_dif_const');
stationary=evalin('base', 'v_m_plus_one');


y=[];
for i=1:d
    e_i=zeros(d, 1);
    e_i(i, 1)=1;
    temp=(r(stationary, vec + epsilon*e_i) - r(stationary, vec))/epsilon;
    y=[y, temp];
end

end


