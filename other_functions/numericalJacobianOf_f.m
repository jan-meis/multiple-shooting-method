function [ y ] = numericalJacobianOf_f( d, f, u, t, epsilon)

y=[];
u_const=constantFunction(u.evaluate(t));
for i=1:d
    e_i=zeros(d, 1);
    e_i(i, 1)=1;
    temp=constantFunction(e_i);
    y=[y, (f(t,u_const+epsilon*temp)-f(t, u_const))/epsilon];
end

end

