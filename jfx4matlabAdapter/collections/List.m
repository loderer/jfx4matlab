classdef List < handle
    %SET Simple implementation of a set. 
    
    properties
        values; 
    end
    
    methods
        function obj = List() 
            obj.values = {-1}; 
        end
        
        function exists = add(obj, value) 
            exists = false; 
            for i = 1:size(obj.values, 2)
                if(isequal(obj.values{i}, value))
                    exists = true; 
                    break;
                end
            end
            if(~exists) 
                added = false; 
                for i = 1:size(obj.values, 2)
                    if(obj.values{i} == -1)
                        obj.values{i} = value; 
                        added = true; 
                        break;
                    end
                end
                if(~added)
                    obj.values{i+1} = value; 
                end
            end
        end
        
        function exists = remove(obj, value) 
           exists = false; 
            for i = 1:size(obj.values, 2)
                if(isequal(obj.values{i}, value))
                    obj.values{i} = -1; 
                    exists = true; 
                    break;
                end
            end
        end
        
        function isEmpty = isEmpty(obj) 
            isEmpty = true; 
            for i = 1:size(obj.values, 2)
                if(obj.values{i} ~= -1)
                    isEmpty = false; 
                    break;
                end
            end
        end
    end
end

