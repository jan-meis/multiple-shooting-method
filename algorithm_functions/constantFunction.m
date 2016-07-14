classdef constantFunction
    
    
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
        
        function ret=plus(obj1, obj2)
            ret=constantFunction(obj1.const+obj2.const);
        end
        
        function ret=mtimes(doubl, obj1)
            ret=constantFunction(obj1.evaluate()*doubl);
        end
        
        
    end
    
end

