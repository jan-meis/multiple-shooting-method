clc
clear variables
close all


%main

parameters



ub=explicitEulerOrder1(t(1, m-1+1), t(1, m+1), v( (m-1)*d+1:(m)*d, 1), @fermi_f, 200);

v( (m+1-1)*d+1:(m+1)*d, 1)=ub.evaluate(t(1, m+1))









%v( (1-1)*d+1:1*d, 1)
%v( (2-1)*d+1:2*d, 1)


%v( (1-1)*d+1:1*d, 1) - v( (2-1)*d+1:2*d, 1)

%F(v, d, r, m)
%DF(v, d, m, t) 

for j=1:300
v=newtonStepForMultipleShooting(v, d, r, m, t)
end;

val={};
for i=1:(m-1)
    erg_temp= explicitEulerOrder1(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), @fermi_f, 200);
    val{end+1}=erg_temp.y;
end

figure
y=[];
for i=1:9
    for k=1:201
    y=[y, val{1, i}{1, k}(1,1)];
    end
end
plot(y)

figure
z=[];
for i=1:9
    for k=1:201
    z=[z, val{1, i}{1, k}(2,1)];
    end
end
plot(z)

