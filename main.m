%clear command Window, variables and figures
clc
clear variables
close all
%add subfolders to PATH
addpath(genpath(pwd))



%******   main   ******%

%initialize parameters specific to problem
parameters_fermi
%parameters_1_d_example
%parameters_generic



%Newton steps
tic

while(newtonNoConvergenceErrorHandling)
    %when iter_count gets too high, newton method will be repeated with
    %different parameters
    newtonNoConvergenceErrorHandling=false;
    iter_count=0;
    
    
    
    %approximation for solution with initial guess for v
    temp_sol={};
    for i=1:(m)
        erg_temp= ivpSolver(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), f, steps);
        temp_sol=[temp_sol; erg_temp];
    end
    v( (m+1-1)*d+1:(m+1)*d, 1)=temp_sol(m).evaluate(t(1, m+1));
    v_m_plus_one=v( (m+1-1)*d+1:(m+1)*d, 1);
    v_cont=[v];
    
    
    %***** main loop ****%
    while not(stopNewtonBool)
        if (size(v_cont, 2) > 3)
            temp_numerator=abs(norm(v_cont(:, size(v_cont, 2))-v_cont(:, size(v_cont, 2)-1))/norm(v_cont(:, size(v_cont, 2)-1)-v_cont(:, size(v_cont, 2)-2)));
            temp_denominator=abs(norm(v_cont(:, size(v_cont, 2)-1)-v_cont(:, size(v_cont, 2)-2))/norm(v_cont(:, size(v_cont, 2)-2)-v_cont(:, size(v_cont, 2)-3)));
            display('current convergence order estimate:')
            alpha_estimate=log(temp_numerator)/log(temp_denominator)
        end
        
        v=newtonStepForMultipleShooting(v, d, r, m, t, steps);
        iter_count=iter_count+1;
        v_1=v( (1-1)*d+1:1*d, 1);
        v_m_plus_one=v( (m+1-1)*d+1:(m+1)*d, 1);
        v_cont=[v_cont, v];
        

        if (iter_count > newton_does_not_seem_to_converge)
            %change starting conditions and try again
            display('Newton method does not seem to converge, doubleing steps and choosing different starting vector now')
            steps=2*steps;
            v=rand([d*(m+1), 1]);
            newtonNoConvergenceErrorHandling=true;
            break;
        end
    end
    
end


display(v)
display(iter_count)
display('Newtons method took:')
toc


%recalculate solution functions with higher number of steps
temp_sol={};
for i=1:(m)
    erg_temp= ivpSolver(t(1, i), t(1, i+1), v( (i-1)*d+1:i*d, 1), f, steps*2);
    temp_sol=[temp_sol; erg_temp];
end


%patch together calculated values to create solution Function
val={};
interval=[];
for i=1:(m)
    if (i==m)
        val=[val, temp_sol(i).y];
        interval=[interval; temp_sol(i).T];
    else
        val=[val, temp_sol(i).y{1:end-1}];
        interval=[interval; temp_sol(i).T(1:end-1)];
        
    end
end
solution=discreteFunctionLinearInterpolation(interval, val);
valMat=cell2mat(val);
difMat=cell2mat(solution.y_dif);


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

if (d > 2)
    %plot d Dimensions
    for i=1:d
    solutionPlot = figure('Name', strcat('Solution Plot Dim ', num2str(i)),'NumberTitle','off');
    solution.plotiD(i);
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
end


%calculate approximation errors and plot them
approx_error=[];
fMat=[];
for i=transpose(solution.T)
    fMat=[fMat, f(i, solution)];

    approx_error = [approx_error, norm(f(i, solution) - solution.differentiate(i))];
end
max_approx_error=max(approx_error)
avg_error = norm(approx_error)/length(approx_error)

errorPlot = figure('Name', 'Error Plot', 'NumberTitle','off');
plot(approx_error);

