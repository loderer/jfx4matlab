classdef JFXSceneController < handle
    %JFXSCENECONTROLLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        stageController; 
        pathToFxml;
        sceneObservable_h;
        jfxThread;
    end
    
    methods
        function obj = JFXSceneController(pathToFxml)
            obj.pathToFxml = pathToFxml;
        end
        
        function init(obj, stageController, sceneHandle) 
            obj.stageController = stageController; 
            obj.jfxThread = sceneHandle.getJfxThread(); 
            obj.sceneObservable_h = handle(sceneHandle.getObservable(),'CallbackProperties');
            set(obj.sceneObservable_h, 'UiEventCallback', @(h,e)obj.onSceneActionBase(e));
        end
        
        function onSceneActionBase(obj, e) 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.closeScene(); 
            elseif(obj.onSceneAction(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' scene: ' char(obj.pathToFxml)...
                    ' type: SceneAction'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
            
        end
        
        function eventConsumed = onSceneAction(~, ~)
            eventConsumed = 0; 
        end
        
        function onStageActionBase(obj, e) 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.closeScene(); 
                obj.stageController.closeStage(); 
            elseif(obj.onStageAction(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' scene: ' char(obj.pathToFxml)...
                    ' type: StageAction'
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
        
        function eventConsumed = onStageAction(~, ~)
            eventConsumed = 0; 
        end
        
        function r = getPathToFxml(obj) 
            r = obj.pathToFxml;
        end
        
        function closeScene(obj) 
            % unregister callback
            set(obj.sceneObservable_h, 'UiEventCallback', '');
        end
        
        function jfxApp = getJfxApp(obj) 
            jfxApp = obj.stageController.getJfxApp();
        end
    end
    
end

