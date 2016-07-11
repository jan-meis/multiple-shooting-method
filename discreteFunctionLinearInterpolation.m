classdef discreteFunctionLinearInterpolation
    
    properties
        T=0;
        y=0;
        d=0;
    end
    
    methods
        function obj=discreteFunctionLinearInterpolation(T_, y_)
            obj.T=T_;
            obj.y=y_;
        end
        
        function ret=evaluate(obj, t)
         for i=1:size(obj.T, 1)-1
             if ((obj.T(i, 1) <= t)&& (t < obj.T(i+1, 1)))
                 ret=obj.y{i}+(t-obj.T(i, 1))*(obj.y{i+1}-obj.y{i});
             end
         end
         
         if (t==obj.T(size(obj.T, 1),1))
             ret=obj.y{size(obj.T, 1)};
         end
         
        end
        
        
        
    end
    
end

