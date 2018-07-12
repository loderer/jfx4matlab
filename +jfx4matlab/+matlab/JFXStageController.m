classdef JFXStageController < handle
    %JFXStageController This class represents a stage of the javaFX
    % application. 
    %   It allows creating a stage and propagating a scene on it. Also it
    %   takes care of registering and unregistering callbacks on the stage.
    %   All events are passed to the respective scene controller. 
    
    properties(Access=private)
        jfxApplicationAdapter;
        title;
        stage; % Appropriate javaFX stage object. 
        stageObservable_h;  % Observable broadcasting all stage events.
        sceneController;    % Respective scene controller. 
    end
    
    methods
        function obj = JFXStageController(varargin)
            % This constructor allows creating modal and non-modal stages.
            % params:
            % jfxApplicationAdapter:    
            % title: The title of the stage.
            % (optional) modality: The modality of the stage.
            % (optionl) owner: The owner of the stage. 
            obj.jfxApplicationAdapter = varargin{1};
            obj.title = varargin{2};
            if(nargin == 2)
                stageHandle = obj.jfxApplicationAdapter.createStage(...
                    obj.title, javafx.stage.Modality.NONE, []);
            elseif(nargin == 3)
                modality = varargin{3}; 
                stageHandle = obj.jfxApplicationAdapter.createStage(...
                    obj.title, modality, []);
            elseif(nargin == 4)
                modality = varargin{3}; 
                ownerController = varargin{4};
                stageHandle = obj.jfxApplicationAdapter.createStage(...
                    obj.title, modality, ownerController.stage);
            else
                msgID = 'EXCEPTION:IllegalArgument';
                msg = 'Illegal number of arguments.';
                throw(MException(msgID,msg));
            end 
            obj.stage = stageHandle.getStage(); 
            obj.stageObservable_h = handle(...
                stageHandle.getObservable(),'CallbackProperties');
            set(obj.stageObservable_h, 'EventCallback', ...
                @(h,e)obj.handleStageEvent(e)); 
            
            obj.sceneController = -1;
        end
        
        function showScene(obj, sceneController) 
            % Propagate the specified scene on this stage. 
            % params: 
            % obj: 
            % sceneController: Controller of the scene to be shown. 
            % width: Width of the scene. 
            % height: Height of the scene. 
            if(obj.sceneController == -1 ...
                    || obj.sceneController.isCloseable())
                obj.sceneController = sceneController;
                sceneHandle = obj.jfxApplicationAdapter.showScene(...
                    obj.stage, sceneController.getPathToFxml());
                sceneController.init(obj, sceneHandle);
                obj.jfxApplicationAdapter.addStageController(obj); 
            end
        end
        
        function unregisterStage(obj) 
            % Unregister all callbacks from the stage.
            set(obj.stageObservable_h, 'EventCallback', '');
            % Unregister stage from JFXApplicationAdapter
            obj.jfxApplicationAdapter.removeStageController(obj);
        end
        
        function mockStageEvent(obj, fxId, action)
            % This method is intended to be used only in tests. It
            % calls the internal handleStageEvent function and allows
            % thereby mocking ui-events. 
            fxId = java.lang.String(fxId);
            action = java.lang.String(action);
            obj.handleStageEvent(struct('fxId', fxId, 'action', action));
        end
        
        function jfxApplicationAdapter = getJfxApplicationAdpater(obj) 
            jfxApplicationAdapter = obj.jfxApplicationAdapter; 
        end
        
        function title = getTitle(obj)
            title = obj.title; 
        end
            
        function stage = getStage(obj)
            stage = obj.stage; 
        end
        
        function sceneController = getSceneController(obj) 
            sceneController = obj.sceneController; 
        end
    end
    
    methods(Access=private) 
        function handleStageEvent(obj, e)
            % This function receives all stage actions. If a
            % sceneController is set all events are passed to it. If no
            % sceneController is set a error is thrown.
            % params: 
            % obj: 
            % event: The stage event. 
            if(obj.sceneController ~= -1) 
                obj.sceneController.handleStageEventBase(e);
            else
                msgID = 'EXCEPTION:NoSceneSet';
                msg = ['Got action but no scene is set!'...
                    ' stage: ' char(obj.title)...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')'];
                throw(MException(msgID,msg));
            end
        end
    end
end

