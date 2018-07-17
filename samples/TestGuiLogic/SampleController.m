classdef SampleController < jfx4matlab.matlab.JFXSceneController
    %SAMPLECONTROLLER Controller class for the sample scene.
    
    properties
        lbl; % The label with the name lbl.
        list; % The listView with the name list. 
    end
    
    methods
        function obj = SampleController(fxml)
            obj = obj@jfx4matlab.matlab.JFXSceneController(fxml);
        end
        
        function initScene(obj)
            obj.lbl = obj.getUiElement('lbl');
            obj.list = obj.getUiElement('list'); 
        end
        
        function eventConsumed = handleSceneEvent(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'btn')...
                    && strcmp(e.action, 'ACTION'))
                % Handle click on btn.
                obj.applyTask(obj.lbl, 'setText', 'heureka');
                eventConsumed = 1;
            end
        end
    end
end

