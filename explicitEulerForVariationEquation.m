function [ y ] = explicitEulerForVariationEquation(initial_arg, end_arg, initial_value, f, u, steps)
values{1}=initial_value;
T=[initial_arg];
h = (end_arg - initial_arg) / steps;
U=constantFunction(initial_value);
for i=2:(steps+1)
    values{i}= values{i-1} + h*f(initial_arg+(i-1)*h, U, u);
    T=[T; initial_arg+(i-1)*h];
    U=constantFunction(values{i});
end

y=discreteFunctionLinearInterpolation(T, values);


end

