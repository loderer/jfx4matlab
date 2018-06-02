classdef Person < handle
    %PERSON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name; 
        surname;
    end
    
    methods
        function obj = Person(name, surname) 
            obj.name = name; 
            obj.surname = surname;
        end
        
        function name = getName(~)
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