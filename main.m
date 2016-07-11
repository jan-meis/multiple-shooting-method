%clear command Window, variables and figures
clc
clear variables
close all
%add subfolders to PATH
addpath(genpath(pwd))


%******   main   ******%

%
parameters


for j=1:10
v=newtonStepForMultipleShooting(v, d, r, m, t, steps)
end;

val={};
interval=[];


for i=1:(m)
    erg_temp= ivpSolver(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), @fermi_f, 300);
    val=[val, erg_temp.y];
    interval=[interval; erg_temp.T];
end



final_erg=discreteFunctionLinearInterpolation(interval, val);


final_erg.plot3D();


for i=transpose(final_erg.T)
    if (i+0.00252 > 5)
        continue;
    end
    if ((max < norm(fermi_f(i, final_erg) - final_erg.differentiate(i))))
        display(i)
        max= norm(fermi_f(i, final_erg) - final_erg.differentiate(i))
    end
end
display(max)








