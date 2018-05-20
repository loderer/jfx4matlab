classdef StageController < handle
    %StageController Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        stage; 
        stageObservable_h;
        sceneController;
    end
    
    methods
        function obj = StageController(stageHandle) 
            obj.stage = stageHandle.getStage();
            obj.stageObservable_h = handle(stageHandle.getObservable(), 'CallbackProperties');
            obj.sceneController = -1; 
            set(obj.stageObservable_h, 'UiEventCallback', @(h,e)obj.notifyThis(e));
        end
        
        function notifyThis(obj, e) 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.unregisterSceneController(); 
            elseif(obj.notify(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
        
        function unregisterSceneController(obj) 
            if(obj.sceneController ~= -1)
                obj.sceneController.unregisterListener();
            end
            obj.sceneController = -1; 
        end
        
        function registerSceneController(obj, sceneController) 
            obj.sceneController = sceneController; 
        end
        
        function unregisterListener(obj) 
            set(obj.stageObservable_h, 'UiEventCallback', '');
        end
        
        function eventConsumed = notify(~, ~)
            eventConsumed = 0; 
        end
        
    end
end

