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
    % to overwrite the handleSceneAction or handleStageAction functions. To change
    % the ui you can fetch the ui elements by calling the getUiElement
    % function. 
    
    properties (Access=private)
        pathToFxml;         % The location of the fxml file to load the
                            % scene from. 
        sceneObservable_h;  % Observable broadcasting all scene events. 
        jfxThread;          % JavaFX application thread. 
    end
    
    properties
        stageController;    % The controller of this scenes stage. 
    end
    
    methods (Access=private)
        function handleSceneActionBase(obj, e) 
            % Handles all scene actions. (All callbacks specified in the
            % fxml file of the scene.) The close action is handled in here.
            % All other actions are passed to the handleSceneAction function.
            % This allows handling the events in a derived class. If the
            % derived class does not handle a event a info will be printed.
            % params:
            % obj:
            % event: The scene event. 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.unregisterScene(); 
            elseif(obj.handleSceneAction(e))
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
            set(obj.sceneObservable_h, 'EventCallback', @(h,e)obj.handleSceneActionBase(e));
            obj.initScene();
        end
         
        function initScene(~) 
            % Initializes the scene. It is recommended to fetch the ui
            % elements first after that they can be initialized. 
        end
        
        function eventConsumed = handleSceneAction(~, ~)
            % To handle any scene action this function should be 
            % overwritten. If the event was consumed the function should
            % return 1 if not 0. 
            % params:
            % obj:
            % event: The scene event. 
            eventConsumed = 0; 
        end
        
        function handleStageActionBase(obj, e) 
            % Handles all stage actions. The close action is handled in 
            % here. All other actions are passed to the handleStageAction 
            % function. This allows handling the events in a derived class. 
            % If the derived class does not handle a event a info will be 
            % printed.
            % params:
            % obj:
            % event: The stage event. 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.close();
            elseif(obj.handleStageAction(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' scene: ' char(obj.pathToFxml)...
                    ' type: StageAction'
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
        
        function eventConsumed = handleStageAction(~, ~)
            % To handle any stage action this function should be 
            % overwritten. If the event was consumed the function should
            % return 1 if not 0. 
            % params:
            % obj:
            % event: The stage event. 
            eventConsumed = 0; 
        end
        
        function r = getPathToFxml(obj) 
            r = obj.pathToFxml;
        end
        
        function unregisterScene(obj) 
            % Unregisters the scene callbacks. 
            set(obj.sceneObservable_h, 'EventCallback', '');
        end
        
        function jfxApp = getJfxApp(obj) 
            jfxApp = obj.stageController.getJfxApplicationAdpater();
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
        
        function ret = applyTask(varargin) 
            % Run a task on the javaFX application thread synchronous. The
            % function returns the result. 
            % params: 
            % obj: 
            % object: The object to invoke the method on.
            % method:    The method to be invoked on the object.
            % ...args:   Any number of arguments. 
            if(nargin == 3) 
                ret = varargin{1}.jfxThread.applyTask(varargin{2}, varargin{3});
            elseif(nargin == 4)
                ret = varargin{1}.jfxThread.applyTask(varargin{2}, varargin{3}, varargin{4:nargin});
            else
                disp('applyTask should always have 3 or 4 input arguments.');
            end
        end
        
        function ret = getUiElement(obj, fxId) 
            % Fetches the ui element with the specified fxId from the
            % scene. 
            % params: 
            % obj: 
            % fxId: FxId of the required ui element. 
            ret = obj.jfxThread.getUiElement(fxId);
        end
        
        function close(obj) 
            % If isCloseable returns 1 the stage containing this scene is
            % closed ditto all callbacks are unregistered. 
            if(obj.isCloseable())
                obj.unregisterScene(); 
                obj.stageController.unregisterStage(); 
                obj.applyTask(obj.stageController.stage, 'close');
            end  
        end
        
        function forceClose(obj) 
            % The stage containing this scene is closed ditto all callbacks 
            % are unregistered even if this stage is not closeable! 
            obj.unregisterScene(); 
            obj.stageController.unregisterStage(); 
            obj.applyTask(obj.stageController.stage, 'close');
        end
        
        function ret = isCloseable(~)
            % Indicates if the scene is closeable. If this function returns
            % 1 the scene is closeable otherwise it is not closable. To
            % prevent a scene from closing you can overwrite this function.
            ret = 1;
        end
    end
    
end

