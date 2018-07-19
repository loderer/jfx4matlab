classdef Map < handle
    % MAP Simple implementation of a map. Each key is contained once.
    
    properties(Access = private)
        head;   % The first item in the map.
    end
    
    methods
        function obj = Map()
            % MAP Creates an empty map.
            obj.head = -1; 
        end
        
        function overwrite = put(obj, key, value) 
            % PUT Add a pair of key and value. 
            % If the key is still contained true will be returned and the
            % associated value will be overwritten.
            %
            % params:
            % key: The key of the item to be added.
            % value: The value of the item to be added.
            %
            % return value: True, if the key is still contained, otherwise
            % false.
            
            overwrite = false; 
            if(isequal(obj.head, -1))
               obj.head = jfx4matlab.matlab.collections.map.MapItem(key, value); 
            else
                actItem = jfx4matlab.matlab.collections.map.MapItem(-1, -1); 
                actItem.setNext(obj.head); 
                while(~isequal(actItem.getNext(), -1))
                    actItem = actItem.getNext();
                    if(isequal(actItem.getKey(), key))
                        actItem.setValue(value); 
                        overwrite = true; 
                        break;
                    end
                end
                if(~overwrite)
                    actItem.setNext(jfx4matlab.matlab.collections.map.MapItem(key, value)); 
                end
            end
        end
        
        function value = get(obj, key)
            % GET Fetches the value associated to the specified key.
            %
            % return value: The value which is associated with the
            % specified key. 
            
            keyContained = false; 
            value = -1;
            if(~isequal(obj.head, -1))  
                actItem = jfx4matlab.matlab.collections.map.MapItem(-1, -1); 
                actItem.setNext(obj.head); 
                while(~isequal(actItem.getNext(), -1))
                    actItem = actItem.getNext();
                    if(isequal(actItem.getKey(), key))
                        value = actItem.getValue(); 
                        keyContained = true; 
                        break;
                    end
                end
            end
            
            if(~keyContained) 
                msgID = 'EXCEPTION:IllegalArgument';
                msg = 'The specified key is not contained.';
                throw(MException(msgID,msg));
            end
        end
        
        function existed = remove(obj, key)
            % REMOVE Removes the pair associated to the specified key.
            %
            % params:
            % key: The key of the pair to be removed.
            %
            % return value: True, if an entry was removed, otherwise false.
            
            existed = false; 
            if(~isequal(obj.head, -1))  
                if(isequal(obj.head.getKey(), key))
                    obj.head = obj.head.getNext();
                    existed = true; 
                else
                    actItem = obj.head(); 
                    while(~isequal(actItem.getNext(), -1))
                        if(isequal(actItem.getNext().getKey(), key))
                            actItem.setNext(actItem.getNext().getNext()); 
                            existed = true; 
                            break;
                        end
                        actItem = actItem.getNext();
                    end
                end
            end
        end
        
        function contains = containsKey(obj, key) 
            % CONTAINSKEY Determines if the key is contained. 
            %
            % params:
            % key: The key whose existence should be checked. 
            %
            % return value: True, if the key is contained, otherwise false.
            
            contains = false; 
            actItem = jfx4matlab.matlab.collections.map.MapItem(-1, -1); 
            actItem.setNext(obj.head); 
            while(~isequal(actItem.getNext(), -1))
                actItem = actItem.getNext();
                if(isequal(actItem.getKey(), key))
                    contains = true;
                    break;
                end
            end
        end
        
        function values = getValues(obj)
            % GETVALUES Fetches all values. 
            %
            % return value: All contained values.
            
            values = jfx4matlab.matlab.collections.list.List(); 
            actItem = jfx4matlab.matlab.collections.map.MapItem(-1, -1); 
            actItem.setNext(obj.head);
            while(~isequal(actItem.getNext(), -1))
                actItem = actItem.getNext();
                values.add(actItem.getValue()); 
            end
        end
    end
end

