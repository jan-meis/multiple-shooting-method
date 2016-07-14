function [ y ] = high_d_example_f( t, u )
u_temp=u.evaluate(t);

y=[ sin(u_temp(1,1));
    cos(u_temp(2,1));
    exp(u_temp(3,1));
    3*u_temp(4,1)^2;
    ];

end

