classdef Person < handle
    %PERSON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id; 
        name; 
        surname;
    end
    
    methods
        function obj = Person(id, name, surname) 
            obj.id = id; 
            obj.name = name; 
            obj.surname = surname;
        end
        
        function id = getId(obj) 
            id = obj.id; 
        end
        
        function setId(obj, id) 
            obj.id = id;  
        end
           
        function name = getName(obj)
            name = obj.name; 
        end
        
        function setName(obj, name) 
            obj.name = name; 
        end
        
        function surname = getSurname(~)
            surname = obj.surname; 
        end
        
        function setSurname(obj, surname) 
            obj.surname = surname; 
        end
    end
end