classdef Person < handle
    %PERSON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id; 
        name; 
        surname;
        gender; 
        age;
    end
    
    methods
        function obj = Person(id, name, surname, gender, age) 
            obj.id = id; 
            obj.name = name; 
            obj.surname = surname;
            obj.gender = gender; 
            obj.age = age;
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
        
        function surname = getSurname(obj)
            surname = obj.surname; 
        end
        
        function setSurname(obj, surname) 
            obj.surname = surname; 
        end
        
        function gender = getGender(obj)
            gender = obj.gender; 
        end
        
        function setGender(obj, gender) 
            obj.gender = gender; 
        end
        
        function age = getAge(obj) 
            age = obj.age; 
        end
        
        function setAge(obj, age) 
            obj.age = age;
        end
    end
end