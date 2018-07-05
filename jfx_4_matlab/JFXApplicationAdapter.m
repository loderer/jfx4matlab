classdef JFXApplicationAdapter < handle
    %JFXApplicationAdapter Wraps the JFXApplication and its functionality. 
    %   This class allows easy access to the functions of the java class 
    %   JFXApplication. 
    
    properties (Access=private)
        jfxApplication; % The JFXApplication object (java).
        allStageControllers; % All existing stageController grouped by name. 
    end
    
    methods
        function obj = JFXApplicationAdapter(jfxrtPath, jfx4matlabPath)
            % This ctor allows specifiing the paths to the javaFX-runtime
            % and to the java-libary jfx_4_matlab.
            if(~exists('jfxrtPath', 'var'))
               jfxrtPath = fullfile(matlabroot,...
                   'sys\java\jre\win64\jre\lib\jfxrt.jar');
            end
            if (~exist('jfx4matlabPath', 'var'))
                [jfx4matlabPath, ~, ~] = fileparts(mfilename('fullpath'));
            end
            
            % Add required libs to path.
            javaaddpathstatic(jfxrtPath);
            javaaddpathstatic(jfx4matlabPath);
            
            obj.jfxApplication = javaObject('jfx_4_matlab.JFXApplication');
            obj.allStageControllers = Map;
        end
        
        function jfxApplication = getJfxApplication(obj) 
            jfxApplication = obj.jfxApplication;
        end
        
        function stageHandle = createStage(obj, title, modality, ownerStage)
            % Creates a new stage. 
            % params: 
            % obj 
            % title: The title of the stage.
            % modality: The modality of the stage.
            % ownerStage: The owner-stage of the new stage. 
           stageHandle = obj.jfxApplication.createStage(title,...
               modality, ownerStage);
        end
        
        function sceneHandle = showScene(...
                obj, stage, pathToFxml) 
            % Propagates the specified scene on the stage. 
            % params: 
            % obj
            % stage: The stage the scene should be propergated on. 
            % pathToFxml: The scenes fxml file. 
            % width: Width of the scene. 
            % height: Height of the scene. 
            sceneHandle = obj.jfxApplication.showScene(...
                stage, pathToFxml);
        end
        
        function addStageController(obj, stageController) 
            % Adds a stageController to the collection of known
            % stageControllers.
            % params: 
            % obj: 
            % stageController: StageController to be added. 
            if(obj.allStageControllers.containsKey(stageController.getTitle()))
               tmpList = obj.allStageControllers.get(stageController.getTitle()); 
               tmpList.add(stageController);
            else
                tmpList = List;
                tmpList.add(stageController);
                obj.allStageControllers.put(stageController.getTitle(), tmpList); 
            end
        end
        
        function removeStageController(obj, stageController) 
            % Removes a stageController from the collection of known
            % stageControllers. 
            % params:
            % obj:
            % stageController: StageController to be removed. 
            if(obj.allStageControllers.containsKey(stageController.getTitle()))
                obj.allStageControllers.get(stageController.getTitle()).remove(stageController); 
                if(obj.allStageControllers.get(stageController.getTitle()).isEmpty())
                    obj.allStageControllers.remove(stageController.getTitle()); 
                end
            end
        end
        
        function stageControllers = getStageControllerByTitle(obj, title)
            % Fetches all StageControllers with the given title. 
            % params:
            % obj: 
            % title: Title of the required StageController. 
            stageControllers = obj.allStageControllers.get(title); 
            if(isequal(stageControllers, -1)) 
                stageControllers = List();  
            end
        end
        
        function stageControllers = getAllStageControllers(obj)
            % Fetches all StageControllers. 
            % params:
            % obj: 
            stageControllers = List(); 
            allStageControllersValues = obj.allStageControllers.getValues(); 
            for i1 = 1 : allStageControllersValues.size()
                for i2= 1 : allStageControllersValues.get(i1).size()
                    value = allStageControllersValues.get(i1).get(i2); 
                    if(value ~= -1)
                        stageControllers.add(value); 
                    end
                end
            end 
        end
    end
end

