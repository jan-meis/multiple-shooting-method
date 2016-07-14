function [ y ] = high_d_example_r( vec_1, vec_2 )

B_a=eye(4);
B_b=eye(4);
c=[2*pi; 0; 1; -5];
y=B_a*vec_1 + B_b*vec_2 -c;


end

