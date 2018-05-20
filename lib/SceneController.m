classdef SceneController < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        stageController; 
        sceneHandle;
        sceneObservable_h; 
    end
    
    methods
        function obj = SceneController(stageController, sceneHandle) 
            obj.stageController = stageController; 
            obj.sceneHandle = sceneHandle;
            stageController.registerSceneController(obj);
            obj.sceneObservable_h = handle(sceneHandle.getObservable(),'CallbackProperties');
            set(obj.sceneObservable_h, 'UiEventCallback', @(h,e)obj.notifyThis(e));
        end
        
        function notifyThis(obj, e) 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.unregisterListener();
            elseif(obj.notify(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
            
        end
        
        function unregisterListener(obj) 
            set(obj.sceneObservable_h, 'UiEventCallback', '');
        end
        
        function eventConsumed = notify(~, ~)
            eventConsumed = 0; 
        end
    end
end

