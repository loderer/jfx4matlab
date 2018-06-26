classdef JFXStageController < handle
    %JFXStageController This class represents a stage of the javaFX
    % application. 
    %   It allows creating a stage and propagating a scene on it. Also it
    %   takes care of registering and unregistering callbacks on the stage.
    %   All events are passed to the respective scene controller. 
    
    properties
        jfxApplicationAdapter;
        title;
        stage; % Appropriate javaFX stage object. 
        stageObservable_h;  % Observable broadcasting all stage events.
        sceneController;    % Respective scene controller. 
    end
    
    methods
        function obj = JFXStageController(varargin)
            % This constructor allows creating modal and non modal stages.
            % If an ownerConroller is specified the new stage will 
            % be modal.
            % params: 
            % stageTitle:   The title of the new stage. 
            % jfxApplicationAdapter:    
            % (optional) ownerConroller: The controller of the owner
            % window.
            obj.title = varargin{1};
            obj.jfxApplicationAdapter = varargin{2};
            if(nargin == 2)
                stageHandle = obj.jfxApplicationAdapter.createStage(obj.title);
            else
                ownerController = varargin{3};
                stageHandle = obj.jfxApplicationAdapter.createStage(obj.title, ownerController);
            end 
            obj.stage = stageHandle.getStage(); 
            obj.stageObservable_h = handle(stageHandle.getObservable(),'CallbackProperties');
            set(obj.stageObservable_h, 'UiEventCallback', @(h,e)obj.onStageAction(e)); 
            
            obj.sceneController = -1;
        end
        
        function onStageAction(obj, e)
            % This function receives all stage actions. If a
            % sceneController is set all events are passed to it. If no
            % sceneController is set a error is thrown.
            % params: 
            % obj: 
            % event: The stage event. 
            if(obj.sceneController ~= -1) 
                obj.sceneController.onStageActionBase(e);
            else
                msgID = 'EXCEPTION:NoSceneSet';
                msg = ['Got action but no scene is set!'...
                    ' stage: ' char(obj.obj.title)...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')'];
                throw(MException(msgID,msg));
            end
        end
        
        function jfxApplicationAdapter = getJfxApplicationAdpater(obj) 
            jfxApplicationAdapter = obj.jfxApplicationAdapter; 
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
            set(obj.stageObservable_h, 'UiEventCallback', '');
            % Unregister stage from JFXApplicationAdapter
            obj.jfxApplicationAdapter.removeStageController(obj);
        end
    end
end

