classdef ListItem < handle
    %LISTITEM An item of a LIST. 
    
    properties(Access=private)
        % The value of the ListItem.
        value; 
        % The ListItem next to this.
        next; 
    end
    
    methods
        function obj = ListItem(value)
            % LISTITEM Creates an item with the specified value.
            
            obj.value = value; 
            obj.next = -1; 
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
        
        function count = childCount(obj) 
            % CHILDCOUNT Returns the number of childs. 
            % Fetches and increases the child-count from the ListItem next to this by one. 
            % If there is no ListItem next to this zero is returned. 
            %
            % return value: The number of child elements.
            
            if(obj.next == -1)
                count = 0; 
            else
                count = obj.next.childCount() + 1; 
            end
        end
        
        function value = get(obj, index) 
            % GET Get the value of an item.
            % If the index is zero the value of this item is returned.
            % Otherwise the index is reduced by one and the function will
            % be called recursively on the ListItem next to this. 
            % 
            % params:
            % index: The index of the value to be returned.
            %
            % return value: The value of the item with the specified index.
            
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
            % SET Replace the value of an item.
            % If the index is zero the value of this is replaced by the new
            % value. Otherwise the index is reduced by one and the function 
            % will be called recursively on the ListItem next to this.
            % 
            % params:
            % index:    The index of the value to be replaced.
            % newValue: The new value to be associated.
            %
            % return value: The value which is replaced.
            
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

