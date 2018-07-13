classdef Map < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        % The first item in the map.
        head; 
    end
    
    methods (Access={?jfx4matlab.matlab.JFXApplicationAdapter,...
            ?jfx4matlab.matlabTest.collections.map.MapTest})
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
            % Fetches the value associated to the specified key. 
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
            % Removes the pair associated to the specified key from the
            % map.
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
            % Determines if the key is contained. 
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
            % Fetches all values. 
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

