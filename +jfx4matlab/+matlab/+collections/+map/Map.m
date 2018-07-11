classdef Map < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        % The first item in the map.
        head; 
    end
    
    methods
        function obj = Map()
            obj.head = -1; 
        end
        
        function overwrite = put(obj, key, value) 
            % Add a pair of key and value. If the key is still contained
            % true will be returned.
            overwrite = false; 
            if(isequal(obj.head, -1))
               obj.head = jfx4matlab.matlab.collections.map.MapItem(key, value); 
            else
                actItem = jfx4matlab.matlab.collections.map.MapItem(-1, -1); 
                actItem.next = obj.head; 
                while(~isequal(actItem.next, -1))
                    actItem = actItem.next;
                    if(isequal(actItem.key, key))
                        actItem.value = value; 
                        overwrite = true; 
                        break;
                    end
                end
                if(~overwrite)
                    actItem.next = jfx4matlab.matlab.collections.map.MapItem(key, value); 
                end
            end
        end
        
        function value = get(obj, key)
            % Fetches the value associated to the specified key. 
            value = -1;
            if(~isequal(obj.head, -1))  
                actItem = jfx4matlab.matlab.collections.map.MapItem(-1, -1); 
                actItem.next = obj.head; 
                while(~isequal(actItem.next, -1))
                    actItem = actItem.next;
                    if(isequal(actItem.key, key))
                        value = actItem.value; 
                        break;
                    end
                end
            end
        end
        
        function existed = remove(obj, key)
            % Removes the pair associated to the specified key from the
            % map.
            existed = false; 
            if(~isequal(obj.head, -1))  
                if(isequal(obj.head.key, key))
                    obj.head = obj.head.next;
                    existed = true; 
                else
                    actItem = jfx4matlab.matlab.collections.map.MapItem(-1, -1); 
                    actItem.next = obj.head; 
                    while(~isequal(actItem.next, -1))
                        actItem = actItem.next;
                        if(isequal(actItem.next.key, key))
                            actItem.next = actItem.next.next; 
                            existed = true; 
                            break;
                        end
                    end
                end
            end
        end
        
        function contains = containsKey(obj, key) 
            % Determines if the key is contained. 
            contains = false; 
            actItem = jfx4matlab.matlab.collections.map.MapItem(-1, -1); 
            actItem.next = obj.head; 
            while(~isequal(actItem.next, -1))
                actItem = actItem.next;
                if(isequal(actItem.key, key))
                    contains = true;
                    break;
                end
            end
        end
        
        function values = getValues(obj)
            % Fetches all values. 
            values = List(); 
            actItem = jfx4matlab.matlab.collections.map.MapItem(-1, -1); 
            actItem.next = obj.head;
            while(~isequal(actItem.next, -1))
                actItem = actItem.next;
                values.add(actItem.value); 
            end
        end
    end
end

