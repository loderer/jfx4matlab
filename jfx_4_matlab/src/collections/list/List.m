classdef List < handle
    %SET Simple implementation of a set. 
    
    properties(Access = private)
        % The first item of the list.
        head; 
    end
    
    methods
        function obj = List() 
            obj.head = -1;
        end
        
        function fill(obj, rawList) 
            % Enables filling the list from a struct. 
            % params:
            % obj
            % rawList: Struct representing list. 
            obj.head = ListItem(-1);
            obj.head.fill(rawList.head); 
        end
        
        function exists = add(obj, value) 
            % Adds a value to the end of the list. 
            % params:
            % obj
            % value: The value to be added.
            exists = false;
            if(obj.head == -1)
                obj.head = ListItem(value); 
            else 
                actItem = ListItem(-1); 
                actItem.next = obj.head; 
                while(actItem.next ~= -1)
                    actItem = actItem.next;
                    if(isequal(actItem.value, value))
                        exists = true; 
                        break; 
                    end 
                end
                if(~exists) 
                    actItem.next = ListItem(value); 
                end
            end
        end
        
        function exists = remove(obj, value) 
            % Removes a value from the list. 
            % params:
            % obj
            % value: The value to be removed.
           exists = false; 
           if(~obj.isEmpty())
               if(isequal(obj.head.value, value))
                    obj.head = obj.head.next;
                    exists = true; 
               else
                   actItem = obj.head; 
                   while(actItem.next ~= -1)
                       if(isequal(actItem.next.value, value))
                           actItem.next = actItem.next.next;
                           exists = true; 
                           break; 
                       end
                   end
               end
           end
            
        end
        
        function isEmpty = isEmpty(obj) 
            % Checks if the list is empty.
            if(obj.head == -1)
                isEmpty = true; 
            else
                isEmpty = false;
            end
        end
        
        function size = size(obj) 
            % Determines the number of contained items.
            if(isequal(obj.head, -1))
                size = 0; 
            else
                size = obj.head.childCount() + 1;
            end 
        end
        
        function value = get(obj, index) 
            % Fetches an item by its index.
            % Use the index one to get the first item!
            % params:
            % obj
            % index: The index of the item to be fetched. 
            value = -1;
            if(index > 0) 
                tmpItem = ListItem(-1); 
                tmpItem.next = obj.head;
                value = tmpItem.get(index);
            end
        end
        
        function oldValue = set(obj, index, newValue) 
            % Replaces an item with another. The item to be replaced is
            % specified by its index.
            % Use the index one to replace the first item!
            % params:
            % obj
            % index: The index of the item to be replaced. 
            % newValue: The new item.
            oldValue = -1;
            if(index > 0) 
                tmpItem = ListItem(-1); 
                tmpItem.next = obj.head;
                oldValue = tmpItem.set(index, newValue);
            end
        end
    end
end

