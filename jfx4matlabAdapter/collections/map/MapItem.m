classdef MapItem < handle; 
    %MAPITEM An item of a map.
    
    properties
        key;
        value; 
        next; 
    end
    
    methods
        function obj = MapItem(key, value)
            obj.key = key; 
            obj.value = value;
            obj.next = -1; 
        end
    end
    
end

