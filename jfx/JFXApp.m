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
        
        function stageHandle = createStage(obj, title) 
            if(~obj.wasPrimaryStageCreated) 
                stageHandle = obj.jfxMain.startGuiThread(title); 
                obj.wasPrimaryStageCreated = 1; 
            else
                stageHandle = obj.jfxMain.newStage(title);
            end
        end
        
        function sceneHandle = showScene(...
                obj, stage, pathToFxml, width, height) 
            sceneHandle = obj.jfxMain.showScene(...
                stage, pathToFxml, width, height);
        end
    end
    
end

