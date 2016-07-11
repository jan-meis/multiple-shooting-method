classdef discreteFunctionLinearInterpolation
    
    properties
        T=0;
        T_dif=0;
        y=0;
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
         
         if (t>=obj.T(size(obj.T, 1),1))
             ret=obj.y{size(obj.T, 1)};
         end
         
        end
        
        function ret=differentiate(obj, t)
 
            for i=1:size(obj.T, 1)-2
                if ((obj.T(i, 1) <= t)&& (t < obj.T(i+1, 1)))
                    temp_1=(obj.y{i+1}-obj.y{i})/(obj.T(i+1, 1)- obj.T(i,1));
                    temp_2=(obj.y{i+2}-obj.y{i+1})/(obj.T(i+2, 1)- obj.T(i+1,1));
                    d_temp=(temp_2-temp_1)/(obj.T(i+1, 1)- obj.T(i,1));
                    ret=temp_1+d_temp*(t-(obj.T(i, 1)));
                end
            end
            
            one_before_last_deriv=
            last_deriv=(obj.y{size(obj.T, 1)}-obj.y{size(obj.T, 1)-1})/(obj.T(size(obj.T, 1), 1)- obj.T(size(obj.T, 1)-1,1));
            
            
            
        end
        
        function ret=intervalLength(obj, i)
            ret=(obj.T(i+1, 1)- obj.T(i,1));
        end
       
        function [a, b, c]=createGraphValues3D(obj)
            a=[];
            b=[];
            c=[];
            for i=1:size(obj.T, 1)
                 a=[a, obj.y{1, i}(1, 1)];
                 b=[b, obj.y{1, i}(2, 1)];
                 c=[c, obj.T(i, 1)];
            end
        end
        
        function [] = plot3D(obj)
            [a, b, c] = obj.createGraphValues3D();
            plot3(a, b, c);
        end
        
        
        
    end
    
end

