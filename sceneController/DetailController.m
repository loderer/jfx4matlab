classdef DetailController < JFXSceneController
    %DetailController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        model;
        person; 
        overviewController; 
        
        % ui elements
        tf_name;
        tf_surname;
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
            % fetch ui elements
            obj.tf_name = obj.getUiElement('tf_name');
            obj.tf_surname = obj.getUiElement('tf_surname');
            
            obj.pushBackTask(obj.tf_name, 'setText', obj.person{1}.name);
            obj.pushBackTask(obj.tf_surname, 'setText', obj.person{1}.surname);
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
            obj.save(); 
            obj.close();
        end
        
        function save(obj) 
           newItem = Person(obj.person{1}.id,...
                obj.applyTask(obj.tf_name, 'getText'),...
                obj.applyTask(obj.tf_surname, 'getText'));
            
            if(obj.person{1}.id == -1) 
                obj.model{1}.addPerson(newItem);
            else
                obj.model{1}.updatePerson(newItem);
            end
            obj.overviewController{1}.update(obj.person{1}, newItem);
            obj.person{1} = newItem; 
        end
        
        function isCloseable = isCloseable(obj)
            newItem = Person(obj.person{1}.id,...
                java.lang.String(obj.applyTask(obj.tf_name, 'getText')),...
                java.lang.String(obj.applyTask(obj.tf_surname, 'getText')));
            if(~strcmp(newItem.name, obj.person{1}.name)...
                    || ~strcmp(newItem.surname, obj.person{1}.surname))
                isCloseable = 0; 
                dialogStageController = JFXStageController('Unsaved changes!', obj.getJfxApp());
                dialogSceneController = DialogController('sample/dialog.fxml', obj);
                dialogStageController.showScene(dialogSceneController, 500, 175);
            else 
                isCloseable = 1;
            end
        end
   end
end
