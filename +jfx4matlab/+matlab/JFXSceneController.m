classdef JFXSceneController < handle
    % JFXSceneController Enables handling user input and changing the ui. 
    % This controller receives all ui events, takes care of the 
    % initialization of the scene and allows changing the scene. If you
    % only want to propagate a ready to use fxml file, you can use this
    % scene controller. If your scene needs to be initialized, you want
    % to react to user input or you want to change the ui dynamically, than
    % you have to extend this class. For initializing the scene you have to
    % overwrite the initScene function. To react on an users input you have
    % to overwrite the handleSceneEvent or handleStageEvent functions. To 
    % change the ui you can fetch the ui elements by calling the 
    % getUiElement function. 
    
    properties (Access=private)
        pathToFxml;         % The location of the fxml file to load the
                            % scene from. 
        sceneObservable_h;  % Observable broadcasting all scene events. 
        jfxThread;          % JavaFX application thread. 
        stageController;    % The controller of this scenes stage. 
        initialized;        % Indicates whether this scene has been initialized. 
    end
    
    % These methods should not be available to the user of the jfx4matlab
    % library.
    methods (Access={?jfx4matlab.matlab.JFXStageController,...
            ?jfx4matlab.matlab.JFXSceneController,...
            ?jfx4matlab.matlabTest.JFXSceneControllerTest})
        function handleSceneEventBase(obj, e) 
            % HANDLESCENEEVENTBASE Handles all scene actions. (All callbacks specified in the fxml file of the scene.)
            % The close action is handled in here. All other actions are 
            % passed to the handleSceneEvent function. This allows handling 
            % the events in a derived class. If the derived class does not 
            % handle a event a info will be printed.
            % 
            % params:
            % event: The scene event. 
            % 
            % See also HANDLESCENEEVENT.
            
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
        
        function unregisterScene(obj) 
            % UNREGISTERSCENE Unregisters the scene callbacks. 
            set(obj.sceneObservable_h, 'EventCallback', '');
        end
     
        function init(obj, stageController, sceneHandle) 
            % INIT Initializes this JFXSceneController.
            % Sets the stageController. Receives the jfxThread from the 
            % scene and registers the callbacks on the scene. In the end
            % the scene is initialized. 
            
            % params: 
            % stageController:  The JFXStageController of the stage 
            %                   containing the scene. 
            % sceneHandle:      The sceneHandle returned at scene creation.
            
            obj.initialized = true; 
            obj.stageController = stageController; 
            obj.jfxThread = sceneHandle.getJfxThread(); 
            obj.sceneObservable_h = handle(sceneHandle.getObservable(), ...
                'CallbackProperties');
            set(obj.sceneObservable_h, 'EventCallback', ...
                @(h,e)obj.handleSceneEventBase(e));
            obj.initScene();
        end
        
        function handleStageEventBase(obj, e) 
            % HANDLESTAGEEVENTBASE Handles all stage actions. 
            % The close action is handled in here. All other actions are 
            % passed to the handleStageEvent function. This allows handling 
            % the events in a derived class. If the derived class does not 
            % handle a event a info will be printed.
            % 
            % params:
            % event: The stage event. 
            %
            % See also HANDLESTAGEEVENT.
            
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.close();
            elseif(obj.handleStageEvent(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' scene: ' char(obj.pathToFxml)...
                    ' type: StageAction'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
    end
        
    methods 
        function obj = JFXSceneController(pathToFxml)
            % JFXSceneController
            % 
            % params:
            % pathToFxml: The path to the appropriate fxml file. 
            
            obj.pathToFxml = pathToFxml;
            obj.sceneObservable_h = [];
            obj.jfxThread = [];
            obj.stageController = []; 
            obj.initialized = false; 
        end
        
        function mockSceneEvent(obj, fxId, action)
            % MOCKSCENEEVENT This function enables mocking events on scene level.
            % This method is intended to be used only in tests. It
            % calls the internal function HANDLESCENEEVENTBASE and allows
            % thereby mocking ui-events. 
            %
            % params:
            % fxId: The fxId of the source of this event. 
            % action: The name of the event.
            
            
            fxId = java.lang.String(fxId);
            action = java.lang.String(action);
            obj.handleSceneEventBase(struct('fxId', fxId, 'action', action));
        end
        
        function pushBackTask(varargin)
            % PUSHBACKTASK Deposit a task for the javaFX application thread.
            %
            % params: 
            % object: The object to invoke the method on.
            % method: The method to be invoked on the object.
            % ...args: Any number of arguments. 
            %
            % See also APPLYTASKS, APPLYTASK.
            
            if(nargin == 3) 
                varargin{1}.jfxThread.pushBackTask(varargin{2}, varargin{3});  
            elseif(nargin > 3) 
                varargin{1}.jfxThread.pushBackTask(varargin{2}, ...
                    varargin{3}, varargin{4:nargin});
            else
                msgID = 'EXCEPTION:IllegalArgument';
                msg = 'pushBackTask should always have 3 or more input arguments.';
                throw(MException(msgID,msg));
            end
        end
        
        function applyTasks(obj) 
            % APPLYTASKS Executes the deposited tasks in the order they were submitted. 
            % After execution the list of deposited tasks is cleared.
            
            obj.jfxThread.applyTasks();
        end
        
        function returnValue = applyTask(varargin) 
            % APPLYTASK Run a task on the javaFX application thread synchronous. 
            % The function returns the result. 
            %
            % params: 
            % object: The object to invoke the method on.
            % method: The method to be invoked on the object.
            % ...args: Any number of arguments. 
            %
            % return value: The return value of the applied task.
            % 
            % See also PUSHBACKTASK, APPLYTASKS.
            
            if(nargin == 3) 
                returnValue = varargin{1}.jfxThread.applyTask(...
                    varargin{2}, varargin{3});
            elseif(nargin > 3)
                returnValue = varargin{1}.jfxThread.applyTask(...
                    varargin{2}, varargin{3}, varargin{4:nargin});
            else
                msgID = 'EXCEPTION:IllegalArgument';
                msg = 'applyTask should always have 3 or more input arguments.';
                throw(MException(msgID,msg));
            end
        end
        
        function uiElement = getUiElement(obj, fxId) 
            % GETUIELEMENT Fetches the ui element with the specified fxId from the scene. 
            % 
            % return value: A reference to the ui element with the
            % specified name.
            %
            % params: 
            % fxId: FxId of the wanted ui element. 
            
            uiElement = obj.jfxThread.getUiElement(fxId);
        end
        
        function close(obj) 
            % CLOSE Closes the stage.
            % If ISCLOSEABLE returns true the stage containing this scene 
            % is closed ditto all callbacks are unregistered. 
            %
            % See also ISCLOSEABLE, FORCECLOSE.
            
            if(obj.isCloseable())
                obj.unregisterScene(); 
                obj.stageController.unregisterStage(); 
                obj.applyTask(obj.stageController.getStage(), 'close');
            end  
        end
        
        function forceClose(obj) 
            % FORCECLOSE Forces closing the stage. 
            % The stage containing this scene is closed ditto all callbacks 
            % are unregistered even if this stage is not closeable! 
            %
            % See also CLOSE.
            
            obj.unregisterScene(); 
            obj.stageController.unregisterStage(); 
            obj.applyTask(obj.stageController.getStage(), 'close');
        end
        
        function jfxApplication = getJfxApplication(obj) 
            if(isequal(obj.stageController, []))
                jfxApplication = [];
            else
                jfxApplication = ...
                    obj.stageController.getJfxApplication();
            end
        end
        
        function r = getPathToFxml(obj) 
            r = obj.pathToFxml;
        end
        
        function stageController = getStageController(obj)
            stageController = obj.stageController;
        end
        
        function initialized = isInitialized(obj)
            initialized = obj.initialized; 
        end
        
        function initScene(~) 
            % INITSCENE Initializes the scene. 
            % It is recommended to fetch the ui elements first after that 
            % they can be initialized. 
        end
        
        function eventConsumed = handleSceneEvent(~, ~)
            % HANDLESCENEEVENT To handle any scene action this function should be overwritten. 
            % If the event was consumed the function should return true 
            % if not false.
            %
            % params:
            % event: The scene event. 
            %
            % return value: True, if the event has been consumed, otherwise
            % false.
            
            eventConsumed = false; 
        end
        
        function eventConsumed = handleStageEvent(~, ~)
            % HANDLESTAGEEVENT To handle any stage action this function should be overwritten. 
            % If the event was consumed the function should return true if 
            % not false. 
            %
            % params:
            % event: The stage event.
            %
            % return value: True, if the event has been consumed, otherwise
            % false.
            
            eventConsumed = false; 
        end
        
        function isCloseable = isCloseable(~)
            % ISCLOSEABLE Indicates if the scene is closeable. 
            % If this function returns true the scene is closeable, 
            % otherwise it is not closable. To prevent a scene from 
            % closing you can overwrite this function.
            %
            % return value: True, if the scene is closeable, otherwise
            % false.
            %
            % See also CLOSE, FORCECLOSE.
            
            isCloseable = true;
        end
    end  
end

