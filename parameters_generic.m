% m = number of Intervals
m = 10

% I = interval
I=[0, 2*pi]

% partitioningMethod self explanatory
partitioningMethod=@equidistantPartitioning


% t = partitioning
t=partitioningMethod(I, m)
%this means t_k = t(1, k+1) for k=0,...,m

%ODE dimension
d=4

% v = initial guess for v vectors

%v=rand([d*(m+1), 1])*0.01;
%nonrandom starting vector:
v=zeros([d*(m+1),1]);
%v(d*(m)+1, 1)=0;
v_initial=v
%this means v_k is v( (k-1)*d+1:k*d, 1) for k=1,..,m+1
v_1=v( (1-1)*d+1:1*d, 1);
v_m_plus_one=v( (m+1-1)*d+1:(m+1)*d, 1);


% r = boundary condition
r = @high_d_example_r
B_a=@generic_B_a
B_b=@generic_B_b


% f = fermi function
f = @high_d_example_f


% df_times_U
df_times_U=@generic_df_times_U


%Initial Value Problem Solver + number of steps
ivpSolver = @explicitEuler
steps=100
numerical_dif_const=0.1;

% stopping_cond && non converg threshold
stopping_cond_epsilon=0.0001
newton_does_not_seem_to_converge = 30;
newtonNoConvergenceErrorHandling=true;




% (bad practice) temporary variable for sharing across workspaces
temp_sol={};
temp_int=0;

stopNewtonBool=false;




 
