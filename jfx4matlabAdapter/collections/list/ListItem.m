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
    end
    
end

