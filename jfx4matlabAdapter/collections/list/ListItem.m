classdef ListItem < handle
    %LISTITEM An item of a list. 
    
    properties
        value; 
        next; 
    end
    
    methods
        function obj = ListItem(value)
            obj.value = value; 
            obj.next = -1; 
        end
        
        function fill(obj, rawItem) 
            obj.value = rawItem.value; 
            if(~isequal(rawItem.next, -1))
                obj.next = ListItem(-1); 
                obj.next.fill(rawItem.next); 
            else
                obj.next = -1; 
            end
        end
        
        function count = childCount(obj) 
            if(obj.next == -1)
                count = 0; 
            else
                count = obj.next.childCount() + 1; 
            end
        end
        
        function value = get(obj, index) 
            if(index == 0)
                value = obj.value; 
            else
                if(obj.next == -1)
                    msgID = 'EXCEPTION:IndexOutOfBounds';
                    msg = 'Index out of bounds exception.';
                    throw(MException(msgID,msg));
                else
                    value = obj.next.get(index - 1); 
                end
            end
        end
        
        function oldValue = set(obj, index, newValue)
            if(index == 0)
                oldValue = obj.value; 
                obj.value = newValue; 
            else
                if(obj.next == -1)
                    msgID = 'EXCEPTION:IndexOutOfBounds';
                    msg = 'Index out of bounds exception.';
                    throw(MException(msgID,msg));
                else
                    oldValue = obj.next.set(index - 1, newValue); 
                end
            end
        end
    end
end

