classdef JFXSceneController < handle
    %JFXSceneController Enables handling user input and changing the
    %ui. 
    %   This controller receives all ui events, takes care of the 
    % initialization of the scene and allows changing the scene. If you
    % only want to propagate a ready to use fxml file you can use this
    % scene controller. If your scene needs to be initialized, you want
    % to react to user input or you want to change the ui dynamically than
    % you have to extend this class. For initializing the scene you have to
    % overwrite the initScene function. To react on an users input you have
    % to overwrite the handleSceneEvent or handleStageEvent functions. To change
    % the ui you can fetch the ui elements by calling the getUiElement
    % function. 
    
    properties (Access=private)
        pathToFxml;         % The location of the fxml file to load the
                            % scene from. 
        sceneObservable_h;  % Observable broadcasting all scene events. 
        jfxThread;          % JavaFX application thread. 
        stageController;    % The controller of this scenes stage. 
    end
    
    methods
        function obj = JFXSceneController(pathToFxml)
            obj.pathToFxml = pathToFxml;
        end
        
        function init(obj, stageController, sceneHandle) 
            % Sets the stageController. Receives the jfxThread from the 
            % scene and registers the callbacks on the scene. In the end
            % the scene is initialized. 
            % params: 
            % obj: 
            % stageController:  The controller of the stage containing the
            %                   scene. 
            % sceneHandle:      The sceneHandle returned at scene creation.
            obj.stageController = stageController; 
            obj.jfxThread = sceneHandle.getJfxThread(); 
            obj.sceneObservable_h = handle(sceneHandle.getObservable(),'CallbackProperties');
            set(obj.sceneObservable_h, 'EventCallback', @(h,e)obj.handleSceneEventBase(e));
            obj.initScene();
        end
         
        function initScene(~) 
            % Initializes the scene. It is recommended to fetch the ui
            % elements first after that they can be initialized. 
        end
        
        function eventConsumed = handleSceneEvent(~, ~)
            % To handle any scene action this function should be 
            % overwritten. If the event was consumed the function should
            % return true if not false. 
            % params:
            % obj:
            % event: The scene event. 
            eventConsumed = false; 
        end
        
        function mockSceneEvent(obj,e)
            % This method is intended to be used only in tests. It
            % calls the internal handleStageEvent function and allows
            % thereby mocking ui-events. 
            obj.handleSceneEventBase(e);
        end
        
        function handleStageEventBase(obj, e) 
            % Handles all stage actions. The close action is handled in 
            % here. All other actions are passed to the handleStageEvent 
            % function. This allows handling the events in a derived class. 
            % If the derived class does not handle a event a info will be 
            % printed.
            % params:
            % obj:
            % event: The stage event. 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.close();
            elseif(obj.handleStageEvent(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' scene: ' char(obj.pathToFxml)...
                    ' type: StageAction'
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
        
        function eventConsumed = handleStageEvent(~, ~)
            % To handle any stage action this function should be 
            % overwritten. If the event was consumed the function should
            % return true if not false. 
            % params:
            % obj:
            % event: The stage event. 
            eventConsumed = false; 
        end
        
        function unregisterScene(obj) 
            % Unregisters the scene callbacks. 
            set(obj.sceneObservable_h, 'EventCallback', '');
        end        
        
        function pushBackTask(varargin)
            % Deposit a task for the javaFX application thread.
            % params: 
            % obj: 
            % object: The object to invoke the method on.
            % method:    The method to be invoked on the object.
            % ...args:   Any number of arguments. 
            if(nargin == 3) 
                varargin{1}.jfxThread.pushBackTask(varargin{2}, varargin{3});  
            elseif(nargin > 3) 
                varargin{1}.jfxThread.pushBackTask(varargin{2}, varargin{3}, varargin{4:nargin});
            else
                disp('pushBackTask should always have 3 or 4 input arguments.');
            end
        end
        
        function applyTasks(obj) 
            % Executes the deposited tasks in the order they were 
            % submitted. After execution the list of deposited tasks is 
            % cleared.
            obj.jfxThread.applyTasks();
        end
        
        function returnValue = applyTask(varargin) 
            % Run a task on the javaFX application thread synchronous. The
            % function returns the result. 
            % params: 
            % obj: 
            % object: The object to invoke the method on.
            % method:    The method to be invoked on the object.
            % ...args:   Any number of arguments. 
            if(nargin == 3) 
                returnValue = varargin{1}.jfxThread.applyTask(varargin{2}, varargin{3});
            elseif(nargin == 4)
                returnValue = varargin{1}.jfxThread.applyTask(varargin{2}, varargin{3}, varargin{4:nargin});
            else
                disp('applyTask should always have 3 or 4 input arguments.');
            end
        end
        
        function uiElement = getUiElement(obj, fxId) 
            % Fetches the ui element with the specified fxId from the
            % scene. 
            % params: 
            % obj: 
            % fxId: FxId of the required ui element. 
            uiElement = obj.jfxThread.getUiElement(fxId);
        end
        
        function close(obj) 
            % If isCloseable returns true the stage containing this scene 
            % is closed ditto all callbacks are unregistered. 
            if(obj.isCloseable())
                obj.unregisterScene(); 
                obj.stageController.unregisterStage(); 
                obj.applyTask(obj.stageController.getStage(), 'close');
            end  
        end
        
        function forceClose(obj) 
            % The stage containing this scene is closed ditto all callbacks 
            % are unregistered even if this stage is not closeable! 
            obj.unregisterScene(); 
            obj.stageController.unregisterStage(); 
            obj.applyTask(obj.stageController.getStage(), 'close');
        end
        
        function isCloseable = isCloseable(~)
            % Indicates if the scene is closeable. If this function returns
            % true the scene is closeable otherwise it is not closable. To
            % prevent a scene from closing you can overwrite this function.
            isCloseable = true;
        end
        
        function jfxApplicationAdapter = getJfxApplicationAdapter(obj) 
            jfxApplicationAdapter = obj.stageController.getJfxApplicationAdpater();
        end
        
        function r = getPathToFxml(obj) 
            r = obj.pathToFxml;
        end
        
        function stageController = getStageController(obj)
            stageController = obj.stageController;
        end
    end
    
    methods (Access=private)
        function handleSceneEventBase(obj, e) 
            % Handles all scene actions. (All callbacks specified in the
            % fxml file of the scene.) The close action is handled in here.
            % All other actions are passed to the handleSceneEvent function.
            % This allows handling the events in a derived class. If the
            % derived class does not handle a event a info will be printed.
            % params:
            % obj:
            % event: The scene event. 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.unregisterScene(); 
            elseif(obj.handleSceneEvent(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' scene: ' char(obj.pathToFxml)...
                    ' type: SceneAction'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
            
        end
    end
end

