classdef JFXApp < handle
    %JFXAPP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        jfxMain;
        wasPrimaryStageCreated; 
    end
    
    methods
        function obj = JFXApp(pathToJfxMainClass)
            obj.jfxMain = javaObject(pathToJfxMainClass);
            obj.wasPrimaryStageCreated = 0; 
        end
        
        function r = isApp(~) 
            r = 1;
        end
        
        function jfxMain = getJfxMain(obj) 
            jfxMain = obj.jfxMain;
        end
        
        function stageHandle = createStage(varargin)
            %params: obj, title, (opt) parentStageController
            obj = varargin{1};
            title = varargin{2};
            if(~obj.wasPrimaryStageCreated) 
                if(nargin == 2)
                    stageHandle = obj.jfxMain.startGuiThread(title);
                else
                    parentStageController = varargin{3};
                    stageHandle = obj.jfxMain.startGuiThread(title, parentStageController.stage);
                end
                 
                obj.wasPrimaryStageCreated = 1; 
            else
                if(nargin == 2)
                    stageHandle = obj.jfxMain.newStage(title);
                else
                    parentStageController = varargin{3};
                    stageHandle = obj.jfxMain.newStage(title, parentStageController.stage);
                end
            end
        end
        
        function sceneHandle = showScene(...
                obj, stage, pathToFxml, width, height) 
            sceneHandle = obj.jfxMain.showScene(...
                stage, pathToFxml, width, height);
        end
    end
    
end

