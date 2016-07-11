function [ y ] = fermiBoundaryCondition(v, vec_1, vec_2, d, m)
helpvec_1=v( (1-1)*d+1:1*d, 1);
helpvec_2=v( (m+1-1)*d+1:(m+1)*d, 1);
helpvec_1(1,1)=1;
helpvec_2(1,1)=0;

temp1=(helpvec_1 - vec_1);
temp2=(helpvec_2 - vec_2);
temp1(1,1)=abs(temp1(1,1));
temp1(2,1)=abs(temp1(2,1));
temp2(1,1)=abs(temp2(1,1));
temp2(2,1)=abs(temp2(2,1));


y= temp1+temp2

end

