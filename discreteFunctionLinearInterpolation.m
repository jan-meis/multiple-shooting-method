classdef discreteFunctionLinearInterpolation
    
    properties
        T=0;
        T_dif=0;
        y=0;
        y_dif=0;
    end
    
    methods
        function obj=discreteFunctionLinearInterpolation(T_, y_)
            obj.T=T_;
            obj.y=y_;
            obj.T_dif=[];
            obj.y_dif={};
            for i=1:size(obj.T, 1)-1
                obj.T_dif=[obj.T_dif; (obj.T(i, 1) + ( (obj.T(i+1, 1)) - (obj.T(i, 1) ) ) / 2)];
                obj.y_dif=[obj.y_dif, (obj.y{i+1}-obj.y{i})/(obj.T(i+1, 1)- obj.T(i,1))];
            end
        end
        
        
        function ret=evaluate(obj, t)
            if (t<obj.T(1,1))
             ret=obj.y{1};
            end
            
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

            if (t<obj.T_dif(1,1))
             ret=obj.y_dif{1};
            end
            
         for i=1:size(obj.T_dif, 1)-1
             if ((obj.T_dif(i, 1) <= t)&& (t < obj.T_dif(i+1, 1)))
                 ret=obj.y_dif{i}+(t-obj.T_dif(i, 1))*(obj.y_dif{i+1}-obj.y_dif{i});
             end
         end
         
         if (t>=obj.T_dif(size(obj.T_dif, 1),1))
             ret=obj.y_dif{size(obj.T_dif, 1)};
         end
            
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
        
        
        function y = lastVal(obj)
            y=obj.y{size(obj.T, 1)};
        end
        
        
        
    end
    
end

