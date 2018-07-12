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
            if(~exist('jfxrtPath', 'var'))
               jfxrtPath = fullfile(matlabroot,...
                   'sys\java\jre\win64\jre\lib\jfxrt.jar');
            end
            if (~exist('jfx4matlabPath', 'var'))
                [jfx4matlabPath, ~, ~] = fileparts(mfilename('fullpath'));
                jfx4matlabPath = fullfile(jfx4matlabPath, '..', '+javaLibs',...
                    'jfx_4_matlab_java.jar');
            end
            
            % Add required libs to path.
            jfx4matlab.javaLibs.javaaddpathstatic(jfxrtPath);
            jfx4matlab.javaLibs.javaaddpathstatic(jfx4matlabPath);
            
            obj.jfxApplication = javaObject('jfx_4_matlab_java.JFXApplication');
            obj.allStageControllers = jfx4matlab.matlab.collections.map.Map;
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
               tmpjfx4matlab.matlab.collections.list.List = ...
                   obj.allStageControllers.get(stageController.getTitle()); 
               tmpjfx4matlab.matlab.collections.list.List.add(stageController);
            else
                tmpjfx4matlab.matlab.collections.list.List = ... 
                    jfx4matlab.matlab.collections.list.List;
                tmpjfx4matlab.matlab.collections.list.List.add(stageController);
                obj.allStageControllers.put(stageController.getTitle(), ...
                    tmpjfx4matlab.matlab.collections.list.List); 
            end
        end
        
        function removeStageController(obj, stageController) 
            % Removes a stageController from the collection of known
            % stageControllers. 
            % params:
            % obj:
            % stageController: StageController to be removed. 
            if(obj.allStageControllers.containsKey(stageController.getTitle()))
                obj.allStageControllers.get(stageController.getTitle()). ...
                    remove(stageController); 
                if(obj.allStageControllers.get(...
                        stageController.getTitle()).isEmpty())
                    obj.allStageControllers.remove(stageController.getTitle()); 
                end
            end
        end
        
        function stageControllers = getStageControllerByTitle(obj, title)
            % Fetches all StageControllers with the given title. 
            % params:
            % obj: 
            % title: Title of the required StageController. 
            if(obj.allStageControllers.containsKey(title))
                stageControllers = obj.allStageControllers.get(title);
            else
                stageControllers = jfx4matlab.matlab.collections.list.List(); 
            end
             
        end
        
        function stageControllers = getAllStageControllers(obj)
            % Fetches all StageControllers. 
            % params:
            % obj: 
            stageControllers = jfx4matlab.matlab.collections.list.List(); 
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

