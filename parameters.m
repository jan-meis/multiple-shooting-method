% m = number of partitions - 1
m = 10

% I = interval
I=[0, 5]

% partitioningMethod self explanatory
partitioningMethod=@equidistantPartitioning


% t = partitioning
t=partitioningMethod(I, m)
%this means t_k = t(1, k+1) for k=0,...,m



% d = dimension of ODE
d=2

% v = d * (m+1)  vector
v=rand([d*(m+1), 1]);
%v=ones([d*(m+1),1]);
%v(d*(m)+1, 1)=0;
%v(1,1)=1;
%v(d*(m)+1, 1)=0;
display(v)

%this means v_k is v( (k-1)*d+1:k*d, 1) for k=1,..,m+1

% init_1, init_2 = initial guesses for boundary conditions,
%note that init_1(1, 1) and init_2(1, 1) is given in exercise
init_1=[1; rand(1)]
init_2=[0; rand(1)]

% r = boundary condition
r = @fermiBoundaryCondition;

% f = fermi function
f = @fermi_f

% df = fermi Df
df = @fermi_df





 
