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
        rb_female; 
        rb_male; 
        slider_age; 
    end
    
    methods
        function obj = DetailController(varargin)
            obj = obj@JFXSceneController(varargin(1, 1));
            obj.model = varargin(1, 2); 
            obj.overviewController = varargin(1, 3);
            if(nargin == 4) 
                obj.person = varargin(1, 4);
            else
                obj.person = {Person(-1, java.lang.String(''), java.lang.String(''), Gender.female, 16)};
            end
        end
        
        function initScene(obj)
            % fetch ui elements
            obj.tf_name = obj.getUiElement('tf_name');
            obj.tf_surname = obj.getUiElement('tf_surname');
            obj.rb_female = obj.getUiElement('rb_female'); 
            obj.rb_male = obj.getUiElement('rb_male');
            obj.slider_age = obj.getUiElement('slider_age'); 
            
            % add label containing actual value to slider
            thumb = obj.slider_age.lookup('.thumb');
            label = javafx.scene.control.Label;
            label.textProperty().bind(obj.slider_age.valueProperty().asString('%.0f'));
            obj.applyTask(thumb.getChildren(), 'add', label);
            
            obj.tf_name.setText(obj.person{1}.name);
            obj.tf_surname.setText(obj.person{1}.surname);
            if(strcmp(obj.person{1}.gender, Gender.female))
               obj.rb_female.setSelected(1); 
            else
                obj.rb_male.setSelected(1);
            end
            obj.applyTask(obj.slider_age, 'setValue', obj.person{1}.age);
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
           % determine gender
           if(obj.rb_female.isSelected())
               gender = Gender.female;
           else
               gender = Gender.male;
           end
            
           newItem = Person(obj.person{1}.id,...
                char(obj.tf_name.getText()),...
                char(obj.tf_surname.getText()),...
                gender,...
                floor(obj.slider_age.getValue()));
            
            if(obj.person{1}.id == -1) 
                obj.model{1}.addPerson(newItem);
            else
                obj.model{1}.updatePerson(newItem);
            end
            obj.overviewController{1}.update(obj.person{1}, newItem);
            obj.person{1} = newItem; 
        end
        
        function isCloseable = isCloseable(obj)
            % determine gender
            if(obj.rb_female.isSelected())
               gender = Gender.female; 
            else
               gender = Gender.male;
            end
            
            newItem = Person(obj.person{1}.id,...
                char(obj.tf_name.getText()),...
                char(obj.tf_surname.getText()),...
                gender,...
                floor(obj.slider_age.getValue()));
            if(~strcmp(newItem.name, obj.person{1}.name)...
                    || ~strcmp(newItem.surname, obj.person{1}.surname)...
                    || ~strcmp(newItem.gender, obj.person{1}.gender)...
                    || newItem.age ~= obj.person{1}.age)
                isCloseable = 0; 
                dialogStageController = JFXStageController('Unsaved changes!', obj.getJfxApp(), obj.stageController);
                dialogSceneController = DialogController('sample_app/dialog.fxml', obj);
                dialogStageController.showScene(dialogSceneController, 400, 146);
            else 
                isCloseable = 1;
            end
        end
   end
end
