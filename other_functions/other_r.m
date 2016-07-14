function [ y ] = other_r( vec_1, vec_2 )

B_a=[1, 0; 0, 0];
B_b=[0, 0; 1, 0];
c=[1; 0];
y=B_a*vec_1 + B_b*vec_2 -c;


end

