classdef List < handle
    %SET Simple implementation of a set. 
    
    properties(Access = private)
        head; 
    end
    
    methods
        function obj = List() 
            obj.head = -1; 
        end
        
        function exists = add(obj, value) 
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
            if(obj.head == -1)
                isEmpty = true; 
            else
                isEmpty = false;
            end
        end
        
        function size = size(obj) 
            if(isequal(obj.head, -1))
                size = 0; 
            else
                size = obj.head.childCount() + 1;
            end 
        end
        
        function value = get(obj, index) 
            % Use the index one to get the first item!
            value = -1;
            if(index > 0) 
                tmpItem = ListItem(-1); 
                tmpItem.next = obj.head;
                value = tmpItem.get(index);
            end
        end
    end
end

