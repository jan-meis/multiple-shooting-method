classdef constantFunction
    %UNTITLED18 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        const=0;
    end
    
    methods
        function obj=constantFunction(const_)
            obj.const=const_;
        end
        
          function ret=evaluate(obj, t)
              ret = obj.const;
         end
        
        
    end
    
end

