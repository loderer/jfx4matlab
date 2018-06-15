classdef Map < handle
    %MAP Simple implementation of a map.
    
    properties
        keys; 
        values; 
    end
    
    methods
        function obj = Map()
            obj.keys = {-1};
            obj.values = {-1};
        end
        
        function overwrite = put(obj, key, value) 
            % Add a pair of key and value. If the key is still contained
            % true will be returned. 
            overwrite = false; 
            for i = 1:size(obj.keys, 2)
                if(isequal(obj.keys{i}, key))
                    obj.values{i} = value; 
                    overwrite = true; 
                    break;
                end
            end
            if(~overwrite) 
                added = false; 
                for i = 1:size(obj.keys, 2)
                    if(obj.keys{i} == -1)
                        obj.keys{i} = key; 
                        obj.values{i} = value; 
                        added = true; 
                        break;
                    end
                end
                if(~added) 
                    i = i + 1; 
                    obj.keys{i} = key; 
                    obj.values{i} = value;
                end
            end
        end
        
        function value = get(obj, key) 
            % Fetches the value associated to the specified key. 
            value = -1; 
            for i = 1:size(obj.keys, 2)
                if(isequal(obj.keys{i}, key))
                    value = obj.values{i};
                    break;
                end
            end
        end
        
        function existed = remove(obj, key) 
            % Removes the pair associated to the specified key from the
            % map.
            existed = false; 
            for i = 1:size(obj.keys, 2)
                if(isequal(obj.keys{i}, key))
                    obj.keys{i} = -1; 
                    obj.values{i} = -1; 
                    existed = true; 
                    break;
                end
            end
        end
        
        function contains = containsKey(obj, key) 
            % Determines if the key is contained. 
            contains = false; 
            for i = 1:size(obj.keys, 2)
                if(isequal(obj.keys{i}, key)) 
                    contains = true; 
                    break;
                end
            end
        end
    end
    
end

