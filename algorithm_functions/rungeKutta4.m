function [ y ] = rungeKutta4(initial_arg, end_arg, initial_value, f, steps)
values{1}=initial_value;
T=[initial_arg];
h = (end_arg - initial_arg) / steps;
u=constantFunction(initial_value);
for i=2:(steps+1)
    k1 = f((initial_arg+(i-1)*h), u);
    k2 = f((initial_arg+(i-1)*h)+h/2, u+constantFunction(k1*h/2));
    k3 = f((initial_arg+(i-1)*h)+h/2, u+constantFunction(k2*h/2));
    k4 = f((initial_arg+(i-1)*h)+h, u+constantFunction(k3*h));
   
    values{i}= values{i-1} + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    T=[T; initial_arg+(i-1)*h];
    u=constantFunction(values{i});
end

y=discreteFunctionLinearInterpolation(T, values);


end

