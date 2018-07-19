classdef JFXApplication < handle
    % JFXAPPLICATION Wraps the GenericJfxApplication and its functionality. 
    % This class allows easy access to the functions of the java class 
    % GenericJfxApplication. 
    
    properties (Access=private)
        genericJfxApplication; % The JFXApplication object (java).
        allStageControllers; % All existing stageController grouped by name. 
    end
    
    methods
        function obj = JFXApplication(jfxrtPath, genericJfxApplicationPath)
            % JFXAPPLICATION
            %
            % params: 
            % jfxrtPath: The path to the javaFX runtime.
            % genericJfxApplicationPath: The path to the java library 
            % generic_jfx_application.
            
            if(~exist('jfxrtPath', 'var'))
               jfxrtPath = fullfile(matlabroot,...
                   'sys\java\jre\win64\jre\lib\jfxrt.jar');
            end
            if (~exist('jfx4matlabPath', 'var'))
                [genericJfxApplicationPath, ~, ~] = ...
                    fileparts(mfilename('fullpath'));
                genericJfxApplicationPath = ...
                    fullfile(genericJfxApplicationPath, '..',...
                    '+javaLibs', 'generic_jfx_application.jar');
            end
            
            % Add required libs to path.
            jfx4matlab.javaLibs.javaaddpathstatic(jfxrtPath);
            jfx4matlab.javaLibs.javaaddpathstatic(genericJfxApplicationPath);
            
            obj.genericJfxApplication = javaObject('generic_jfx_application.GenericJfxApplication');
            obj.allStageControllers = jfx4matlab.matlab.collections.map.Map;
        end
        
        function genericJfxApplication = getGenericJfxApplication(obj) 
            genericJfxApplication = obj.genericJfxApplication;
        end
        
        function stageHandle = createStage(obj, title, modality, ownerStage)
            % CREATESTAGE Creates a new stage. 
            %
            % params: 
            % title: The title of the stage.
            % modality: The modality of the stage.
            % ownerStage: The owner stage of the new stage. 
            % 
            % return value: StageHandle containing all data concerning the
            % new stage.
            
           stageHandle = obj.genericJfxApplication.createStage(title,...
               modality, ownerStage);
        end
        
        function sceneHandle = showScene(...
                obj, stage, pathToFxml) 
            % SHOWSCENE Propagates the specified scene on a stage. 
            %
            % params: 
            % stage: The stage the scene should be propergated on. 
            % pathToFxml: The scenes fxml file. 
            % width: Width of the scene. 
            % height: Height of the scene. 
            %
            % return value: SceneHandle containing all data concerning the
            % new scene.
            
            sceneHandle = obj.genericJfxApplication.showScene(...
                stage, pathToFxml);
        end
        
        function stageControllers = getStageControllerByTitle(obj, title)
            % GETSTAGECONTROLLERBYTITLE Fetches all JFXStageControllers with the given title. 
            %
            % params:
            % title: Title of the wanted StageControllers.
            %
            % return value: All visible JFXStageControllers with the 
            % specified title.
            %
            % See also GETALLSTAGECONTROLLERS.
            
            if(obj.allStageControllers.containsKey(title))
                stageControllers = obj.allStageControllers.get(title);
            else
                stageControllers = jfx4matlab.matlab.collections.list.List(); 
            end
             
            stageControllers = stageControllers.toCell(); 
        end
        
        function stageControllers = getAllStageControllers(obj)
            % GETALLSTAGECONTROLLERS Fetches all JFXStageControllers. 
            % 
            % return value: All visible JFXStageControllers of this
            % application.
            %
            % See also GETSTAGECONTROLLERBYTITLE.
            
            stageControllers = jfx4matlab.matlab.collections.list.List(); 
            
            for listIndex = 1 : obj.allStageControllers.getValues().size()
                for stageControllerIndex = 1 : obj.allStageControllers.getValues().get(listIndex).size()
                    stageController = obj.allStageControllers.getValues().get(listIndex).get(stageControllerIndex);
                    stageControllers.add(stageController); 
                end
            end
            
            stageControllers = stageControllers.toCell(); 
        end
        
        function addStageController(obj, stageController) 
            % ADDSTAGECONTROLLER Adds a JFXStageController to the collection of known stageControllers.
            %
            % params: 
            % stageController: StageController to be added.
            %
            % See also REMOVESTAGECONTROLLER.
            
            
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
            % REMOVESTAGECONTROLLER Removes a JFXStageController from the collection of known stageControllers. 
            % 
            % params:
            % stageController: StageController to be removed. 
            %
            % See also ADDSTAGECONTROLLER.
            
            if(obj.allStageControllers.containsKey(stageController.getTitle()))
                obj.allStageControllers.get(stageController.getTitle()). ...
                    remove(stageController); 
                if(obj.allStageControllers.get(...
                        stageController.getTitle()).isEmpty())
                    obj.allStageControllers.remove(stageController.getTitle()); 
                end
            end
        end
    end
end

