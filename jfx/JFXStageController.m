classdef JFXStageController < handle
    %JFXSTAGECONTROLLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        jfxApp;
        stage; 
        stageObservable_h;
        sceneController;
    end
    
    methods
        function obj = JFXStageController(varargin)
            %param: stageTitle, jfxApp, (opt) parentStageController
            stageTitle = varargin{1};
            obj.jfxApp = varargin{2};
            if(nargin == 2)
                stageHandle = obj.jfxApp.createStage(stageTitle);
            else
                parentStageController = varargin{3};
                stageHandle = obj.jfxApp.createStage(stageTitle, parentStageController);
            end 
            obj.stage = stageHandle.getStage(); 
            obj.stageObservable_h = handle(stageHandle.getObservable(),'CallbackProperties');
            set(obj.stageObservable_h, 'UiEventCallback', @(h,e)obj.onStageAction(e)); 
            
            obj.sceneController = -1;
        end
        
        function onStageAction(obj, e)
            if(obj.sceneController ~= -1) 
                obj.sceneController.onStageActionBase(e);
            else
                disp(['Got action but no scene is set!'...
                    ' stage: ' char(obj.stageTitle)...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
        
        function jfxApp = getJfxApp(obj) 
            jfxApp = obj.jfxApp; 
        end
        
        function showScene(obj, sceneController, width, height) 
            if(obj.sceneController == -1 ...
                || obj.sceneController.isCloseable())
                obj.sceneController = sceneController;
                sceneHandle = obj.jfxApp.showScene(...
                    obj.stage, sceneController.getPathToFxml(), width, height);
                sceneController.init(obj, sceneHandle);
            end
        end
        
        function closeStage(obj) 
            % unregister callback
            set(obj.stageObservable_h, 'UiEventCallback', '');
        end
    end
end

