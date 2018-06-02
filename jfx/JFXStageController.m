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
        function obj = JFXStageController(stageTitle, jfxApp)
            obj.jfxApp = jfxApp;
            stageHandle = jfxApp.createStage(stageTitle); 
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
            obj.sceneController = sceneController;
            sceneHandle = obj.jfxApp.showScene(...
                obj.stage, sceneController.getPathToFxml(), width, height);
            sceneController.init(obj, sceneHandle);
        end
        
        function closeStage(obj) 
            % unregister callback
            set(obj.stageObservable_h, 'UiEventCallback', '');
        end
    end
end

