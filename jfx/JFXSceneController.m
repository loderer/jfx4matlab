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
            obj.initScene();
        end
        
        % Dient im Telefonbuch-Beispiel dem vorbefüllen der Tabelle. 
        % Kann grundsätzlich zum initialisieren der GUI genutzt werden. 
        function initScene(~) 
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
        
        function pushBackTask(varargin)
            if(nargin == 3) 
                varargin{1}.jfxThread.pushBackTask(varargin{2}, varargin{3});  
            elseif(nargin == 4) 
                varargin{1}.jfxThread.pushBackTask(varargin{2}, varargin{3}, varargin{4});
            else
                disp('pushBackTask should always have 3 or 4 input arguments.');
            end
        end
        
        function applyTasks(obj) 
            obj.jfxThread.applyTasks();
        end
        
        function ret = applyTask(varargin) 
            if(nargin == 3) 
                ret = varargin{1}.jfxThread.applyTask(varargin{2}, varargin{3});
            elseif(nargin == 4)
                ret = varargin{1}.jfxThread.applyTask(varargin{2}, varargin{3}, varargin{4});
            else
                disp('applyTask should always have 3 or 4 input arguments.');
            end
        end
        
        function ret = getUiElement(obj, fxId) 
            ret = obj.jfxThread.getUiElement(fxId);
        end
        
        function close(obj) 
            obj.jfxThread.closeStage();  
        end
    end
    
end

