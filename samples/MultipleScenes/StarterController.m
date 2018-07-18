classdef StarterController < jfx4matlab.matlab.JFXSceneController
    %STARTERCONTROLLER Controller class for the starter scene.
    
    methods
        function obj = StarterController(fxml)
            obj = obj@jfx4matlab.matlab.JFXSceneController(fxml);
        end
        
        function eventConsumed = handleSceneEvent(obj, e) 
            eventConsumed = 0; 
            
            % Determine path to sample.fxml
            [pathToThisDir, ~, ~] = fileparts(mfilename('fullpath'));
            pathToFxml = fullfile(pathToThisDir, 'sample.fxml');
            
            if(strcmp(e.fxId, 'btn_openInOtherWindow')...
                    && strcmp(e.action, 'ACTION'))
                obj.openSampleInOtherWindow(pathToFxml); 
                eventConsumed = 1;
            elseif(strcmp(e.fxId, 'btn_openInThisWindow')...
                    && strcmp(e.action, 'ACTION'))
                obj.openSampleInThisWindow(pathToFxml); 
                eventConsumed = 1;
            end
        end
        
        function openSampleInOtherWindow(obj, pathToFxml)
            % Create stage. 
            stageController = jfx4matlab.matlab.JFXStageController(...
                obj.getJfxApplication(), 'Hello World');
            % Create scene
            sceneController = SampleController(pathToFxml);
            stageController.showScene(sceneController);
        end
        
        function openSampleInThisWindow(obj, pathToFxml)
            % Create scene
            sceneController = SampleController(pathToFxml);
            obj.getStageController().showScene(sceneController);
        end
    end
end

