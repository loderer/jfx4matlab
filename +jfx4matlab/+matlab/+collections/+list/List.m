classdef List < handle
    % LIST Simple implementation of a list. 
    % It is ensured that each value is contained only once. 
    
    properties(Access = private)
        head;   % The first item of the list.
    end
    
    methods
        function obj = List() 
            % LIST Creates an empty list.
            
            obj.head = -1;
        end
        
        function exists = add(obj, value) 
            % ADD Adds a value to the end of the list.
            % A value is only added if it is not still contained.
            % If the value is still contained true is returned, otherwise
            % false.
            %
            % params:
            % value: The value to be added.
            %
            % return value: True, if the value is still contained,
            % otherwise false.
            
            exists = false;
            if(obj.head == -1)
                obj.head = jfx4matlab.matlab.collections.list.ListItem(value); 
            else 
                actItem = jfx4matlab.matlab.collections.list.ListItem(-1); 
                actItem.setNext(obj.head); 
                while(actItem.getNext() ~= -1)
                    actItem = actItem.getNext();
                    if(isequal(actItem.getValue(), value))
                        exists = true; 
                        break; 
                    end 
                end
                if(~exists) 
                    actItem.setNext(jfx4matlab.matlab.collections.list. ...
                        ListItem(value)); 
                end
            end
        end
        
        function exists = remove(obj, value) 
            % REMOVE Removes a value from the list. 
            % If the value was contained true is returned,
            % otherwise false. 
            %
            % params:
            % value: The value to be removed.
            %
            % return value: True, if the value existed, otherwise false.
            
           exists = false; 
           if(~obj.isEmpty())
               if(isequal(obj.head.getValue(), value))
                    obj.head = obj.head.getNext();
                    exists = true; 
               else
                   actItem = obj.head; 
                   while(actItem.getNext() ~= -1)
                       if(isequal(actItem.getNext().getValue(), value))
                           actItem.setNext(actItem.getNext().getNext());
                           exists = true; 
                           break; 
                       end
                       actItem = actItem.getNext(); 
                   end
               end
           end
        end
        
        function isEmpty = isEmpty(obj) 
            % ISEMPTY Checks if the list is empty.
            %
            % return value: True, if the list is empty, otherwise false.
            
            if(obj.head == -1)
                isEmpty = true; 
            else
                isEmpty = false;
            end
        end
        
        function size = size(obj) 
            % SIZE Determines the number of contained items.
            %
            % return value: The number of contained items.
            
            if(isequal(obj.head, -1))
                size = 0; 
            else
                size = obj.head.childCount() + 1;
            end 
        end
        
        function value = get(obj, index) 
            % GET Fetches an item by its (one based) index.
            % Use the index one to get the first item!
            %
            % params:
            % index: The index of the item to be fetched. 
            %
            % return value: The value of the item with the specified index.
            
            if(index > 0) 
                tmpItem = jfx4matlab.matlab.collections.list.ListItem(-1); 
                tmpItem.setNext(obj.head);
                value = tmpItem.get(index);
            else
                msgID = 'EXCEPTION:IndexOutOfBounds';
                msg = 'The first possible index in a list is one.';
                throw(MException(msgID,msg));
            end
        end
        
        function oldValue = set(obj, index, newValue) 
            % SET Replaces an item with another. 
            % The item to be replaced is specified by its (one based) index.
            % Use the index one to replace the first item!
            %
            % params:
            % index: The index of the item to be replaced. 
            % newValue: The new item.
            %
            % return value: The value which was replaced.
            
            if(index > 0) 
                tmpItem = jfx4matlab.matlab.collections.list.ListItem(-1); 
                tmpItem.setNext(obj.head);
                oldValue = tmpItem.set(index, newValue);
            else
                msgID = 'EXCEPTION:IndexOutOfBounds';
                msg = 'The first possible index in a list is one.';
                throw(MException(msgID,msg));
            end
        end
        
        function value = toCell(obj) 
            % TOCELL Creates an cell representation of this list.
            %
            % return value: A cell representation of this list.
            
            value=cell(obj.size(), 1);
            for i = 1 : obj.size()
                value{i, 1} = obj.get(i);
            end
        end
    end
end

