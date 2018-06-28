classdef MapItem < handle; 
    %MAPITEM An item of a map.
    
    properties
        % The key of this.
        key;
        % The value of this.
        value; 
        % The MapItem next to this.
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

