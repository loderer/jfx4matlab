classdef MapItem < handle; 
    %MAPITEM An item of a map.
    
    properties(Access=private)
        % The key of this.
        key;
        % The value of this.
        value; 
        % The MapItem next to this.
        next; 
    end
    
    methods (Access={?jfx4matlab.matlab.collections.map.Map,...
            ?jfx4matlab.matlabTest.collections.map.MapItemTest})
        function obj = MapItem(key, value)
            obj.key = key; 
            obj.value = value;
            obj.next = -1; 
        end
        
        function key = getKey(obj) 
            key = obj.key; 
        end
        
        function setKey(obj, key) 
            obj.key = key; 
        end
        
        function value = getValue(obj) 
            value = obj.value; 
        end
        
        function setValue(obj, value) 
            obj.value = value; 
        end
        
        function next = getNext(obj) 
            next = obj.next; 
        end
        
        function setNext(obj, next) 
            obj.next = next; 
        end
    end
end

