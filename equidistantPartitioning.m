function [ y ] = equidistantPartitioning(I, k)
y=zeros([1 k]);
for i=0:k
    y(1,i+1) = ((I(1,2)-I(1,1))/k)*i;
end


end
