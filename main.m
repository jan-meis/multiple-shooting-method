%clear command Window, variables and figures
clc
clear variables
close all
%add subfolders to PATH
addpath(genpath(pwd))


%******   main   ******%

%initialize parameters specific to problem
parameters
%parameters_1_d_example


%Newton steps
tic
iter_count=0;


temp_sol={};
for i=1:(m)
    erg_temp= ivpSolver(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), f, steps);
    temp_sol=[temp_sol; erg_temp];
end
v( (m+1-1)*d+1:(m+1)*d, 1)=temp_sol(m).evaluate(t(1, m+1));


while not(stopNewton(stopping_cond_epsilon, ivpSolver, f, v, d, m, r, t))
    v=newtonStepForMultipleShooting(v, d, r, m, t, steps);
    iter_count=iter_count+1;
    
    temp_sol={};
    for i=1:(m)
        erg_temp= ivpSolver(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), f, steps);
        temp_sol=[temp_sol; erg_temp];
    end
    assignin('base', 'temp_sol', temp_sol)
    
end
display(v)
display(iter_count)
'Newton method took:'
toc


%patch together calculated values to create solution Function
val={};
interval=[];
for i=1:(m)
    if (i==1)
        val=[val, temp_sol(i).y];
        interval=[interval; temp_sol(i).T];
    else
        val=[val, temp_sol(i).y{2:end}];
        interval=[interval; temp_sol(i).T(2:end)];
        
    end
end
solution=discreteFunctionLinearInterpolation(interval, val);
valMat=cell2mat(val);

if (d==2)
    %plot 2D
    solutionPlot = figure('Name', 'Solution Plot','NumberTitle','off');
    solution.plot3D();
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
end

if (d==1)
    %plot 1D
    
    solutionPlot = figure('Name', 'Solution Plot','NumberTitle','off');
    solution.plot2D();
    grid on;
    xlabel('t');
    ylabel('y');
    
    axis auto;
    a = axis;
    amax = max(abs(a));
    axis([-amax,amax,-amax,amax]);
    hold on
    cordSysX=[-amax, amax ];
    cordSysY=[0,0];
    plot(cordSysX, cordSysY, 'k');
    
    hold on
    cordSysX=[0,0];
    cordSysY=[-amax, amax ];
    plot(cordSysX, cordSysY, 'k');
    
end


%calculate approximation errors and plot them
approx_error=[];
for i=transpose(solution.T)
    approx_error = [approx_error, norm(f(i, solution) - solution.differentiate(i))];
end
max_approx_error=max(approx_error)

errorPlot = figure('Name', 'Error Plot', 'NumberTitle','off');
plot(approx_error);








