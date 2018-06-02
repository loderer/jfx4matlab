classdef DetailController < JFXSceneController
    %DetailController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        person; 
    end
    
    methods
        function obj = DetailController(varargin)
            obj = obj@JFXSceneController(varargin(1));
            if(nargin == 2) 
                obj.person = varargin(2);
            else
                obj.person = -1;
            end
        end
        
        function initScene(obj)
            if(obj.person == -1) 
                tmpPerson = Person (java.lang.String(''), java.lang.String(''));
            else
                tmpPerson = obj.person;
            end
             
            obj.pushBackTask('tf_name', 'setText', tmpPerson.name);
            obj.pushBackTask('tf_surname', 'setText', tmpPerson.surname);
            obj.applyTasks();
        end
        
        function eventConsumed = onSceneAction(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'btn_save')...
                    && strcmp(e.action, 'ACTION'))
                obj.btnSavePressed();
                eventConsumed = 1; 
            end
        end
        
        function btnSavePressed(~)
            disp('btn_save pressed!!!');
            
        end
    end
end
