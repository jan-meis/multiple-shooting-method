%clear command Window, variables and figures
clc
clear variables
close all
%add subfolders to PATH
addpath(genpath(pwd))


%******   main   ******%

%initialize parameters specific to problem
parameters



%Newton steps
iter_count=0;
while not(stopNewton(stopping_cond_epsilon, ivpSolver, f, v, d, m, r, t))
    v=newtonStepForMultipleShooting(v, d, r, m, t, steps);
    iter_count=iter_count+1;
end
display(v)
display(iter_count)

%use our calculated v to assign assign a discrete solution function to
%final_erg
val={};
interval=[];
for i=1:(m)
    erg_temp= ivpSolver(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), f, steps);
    val=[val, erg_temp.y];
    interval=[interval; erg_temp.T];
end
final_erg=discreteFunctionLinearInterpolation(interval, val);


%plot Solution
solutionPlot = figure('Name', 'Solution Plot','NumberTitle','off');
final_erg.plot3D();
grid on;
xlabel('x');
ylabel('y');
zlabel('t');

axis auto;
a = axis;
amax = max(abs(a));
axis([-amax,amax,-amax,amax,-amax,amax]);
hold on
cordSysX=[-amax/2, amax/2 ];
cordSysY=[0,0];
cordSysZ=[0,0];

plot3(cordSysX, cordSysY, cordSysZ, 'k');
hold on
cordSysX=[0,0];
cordSysY=[-amax/2, amax/2 ];
cordSysZ=[0,0];
plot3(cordSysX, cordSysY, cordSysZ, 'k');
hold on
cordSysX=[0,0];
cordSysY=[0,0];
cordSysZ=[-amax/2, amax/2 ];
plot3(cordSysX, cordSysY, cordSysZ, 'k');



%calculate approximation errors and plot them
approx_error=[];
for i=transpose(final_erg.T)
    approx_error = [approx_error, norm(f(i, final_erg) - final_erg.differentiate(i))];
end
max_approx_error=max(approx_error)

errorPlot = figure('Name', 'Error Plot', 'NumberTitle','off');
plot(approx_error);








