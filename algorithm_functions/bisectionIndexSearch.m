function [ i, k ] = bisectionIndexSearch( T, t, max )
i=int32(1); 
j=int32(fix(max/2));
k=int32(max);
while (true)
    if (i==j || j==k)
        return
    end
    
    
    if (t<T(j))
        k=j;
        j=int32(fix((i+k)/2));
    else
        i=j;
        j=int32(fix((i+k)/2));
    end
end







end

