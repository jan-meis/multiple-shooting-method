function [ y ] = linearBoundaryValueCondition( vec_1, vec_2 )
c = evalin('base', 'c');
r = evalin('base', 'r');
B_a= evalin('base', 'B_a');
B_b= evalin('base', 'B_b');

temp_B_a=B_a(r, vec_1);
temp_B_b=B_b(r, vec_2);

y=temp_B_a*vec_1 + temp_B_b*vec_2 - c;

end

