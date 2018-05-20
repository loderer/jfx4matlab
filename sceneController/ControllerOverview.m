classdef ControllerOverview < SceneController
    %ControllerOverview An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        jfxMain; 
    end
    
    methods
        function obj = ControllerOverview(stageController,... 
                sceneHandle, jfxMain) 
            obj = obj@SceneController(stageController, sceneHandle);
            obj.jfxMain = jfxMain; 
        end
        
        function eventConsumed = notify(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'btn_newEntry')...
                    && strcmp(e.action, 'ACTION'))
                obj.btnNewEntryPressed();
                eventConsumed = 1; 
            end
        end
        
        function btnNewEntryPressed(obj) 
            detailStageHandle = obj.jfxMain.newStage('Detail'); 
            SceneController(obj.stageController,...
                obj.jfxMain.showScene(detailStageHandle.getStage(), 'sample/detail.fxml'));
        end
    end
end
