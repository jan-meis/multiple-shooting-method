clc
clear variables
close all


%main

parameters


F(v, d, r, m, t);
DF(v, d, m, t);
(DF(v, d, m, t))^(-1);
((DF(v, d, m, t))^(-1))*F(v, d, r, m, t);







%v( (1-1)*d+1:1*d, 1)
%v( (2-1)*d+1:2*d, 1)


%v( (1-1)*d+1:1*d, 1) - v( (2-1)*d+1:2*d, 1)

%F(v, d, r, m)
%DF(v, d, m, t) 

for j=1:30
v=newtonStepForMultipleShooting(v, d, r, m, t)
end;

val={};
interval=[];
for i=1:(m)
    erg_temp= explicitEulerOrder1(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), @fermi_f, 200);
    
    val=[val, erg_temp.y];
    interval=[interval; erg_temp.T];
end


x=[];
y=[];
z=[];
final_erg=discreteFunctionLinearInterpolation(interval, val);
for i=1:2010
    x=[x, val{1, i}(1, 1)];
    y=[y, val{1, i}(2, 1)];
    z=[z, interval(i, 1)];
end

plot3(x,y,z)








