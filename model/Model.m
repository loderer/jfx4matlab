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
            obj.readJson();
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
        
        function writeJson(obj) 
            jsonStr = savejson('', obj);
            fid = fopen('C:\Users\rudi\Documents\GitHub\BaMatlab\persistentModel.json', 'w');
            if fid == -1, error('Cannot create JSON file'); end
            fwrite(fid, jsonStr, 'char');
            fclose(fid);
        end
        
        function readJson(obj)
            if(exist('C:\Users\rudi\Documents\GitHub\BaMatlab\persistentModel.json', 'file') == 2)
                persistentModel = loadjson('C:\Users\rudi\Documents\GitHub\BaMatlab\persistentModel.json');
                obj.id = persistentModel.id; 
                obj.person = persistentModel.person;
            end
        end
    end
    
end

