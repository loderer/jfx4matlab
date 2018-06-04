classdef Model < handle
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id; 
        person;
    end
    
    methods
        function obj = Model()
            obj.id = 0; 
            obj.person = []; 
        end
        
        function addPerson(obj, person) 
            person.setId(obj.id);
            position = size(obj.person, 2) + 1;
            obj.person{position} = person;
            obj.id = obj.id + 1;
        end
        
        function updatePerson(obj, person) 
            for i=1:size(obj.person)
                if(obj.person{i}.id == person.id)
                    break;
                end
            end
            obj.person{i} = person;
        end
    end
    
end

