classdef DetailController < JFXSceneController
    %DetailController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        model;
        person; 
        overviewController; 
    end
    
    methods
        function obj = DetailController(varargin)
            obj = obj@JFXSceneController(varargin(1, 1));
            obj.model = varargin(1, 2); 
            obj.overviewController = varargin(1, 3);
            if(nargin == 4) 
                obj.person = varargin(1, 4);
            else
                obj.person = {Person(-1, java.lang.String(''), java.lang.String(''))};
            end
        end
        
        function initScene(obj)
            obj.pushBackTask('tf_name', 'setText', obj.person{1}.name);
            obj.pushBackTask('tf_surname', 'setText', obj.person{1}.surname);
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
        
        function btnSavePressed(obj)
            newItem = Person(obj.person{1}.id,...
                obj.applyTask('tf_name', 'getText'),...
                obj.applyTask('tf_surname', 'getText'));
            
            if(obj.person{1}.id == -1) 
                obj.model{1}.addPerson(newItem);
            else
                obj.model{1}.updatePerson(newItem);
            end
            obj.overviewController{1}.update(obj.person{1}, newItem);
            obj.person{1} = newItem;
            obj.close();
        end
    end
end
