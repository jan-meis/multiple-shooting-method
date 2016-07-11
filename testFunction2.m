function [ y ] = testFunction2( x )
testing = evalin('base', 'testing')
y=testing(x);

end

