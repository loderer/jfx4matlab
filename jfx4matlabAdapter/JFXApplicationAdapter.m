classdef JFXApplicationAdapter < handle
    %JFXApplicationAdapter Wraps the JFXApplication and its functionality. 
    %   This class allows easy access to the functions of the java class 
    %   JFXApplication. 
    
    properties (Access=private)
        jfxApplication; % The JFXApplication object (java).
        allStageControllers; % All existing stageController grouped by name. 
    end
    
    methods
        function obj = JFXApplicationAdapter()
            
            % Add required libs to path.
            javaaddpathstatic(Config.jfxrtPath);
            javaaddpathstatic(Config.jfx4matlabPath);
            
            obj.jfxApplication = javaObject('jfx_4_matlab.JFXApplication');
            obj.allStageControllers = Map;
        end
        
        function jfxApplication = getJfxApplication(obj) 
            jfxApplication = obj.jfxApplication;
        end
        
        function stageHandle = createStage(varargin)
            % Creates a new stage. 
            % params: 
            % obj 
            % title: The title of the stage.
            % modality: The modality of the stage.
            % ownerStage: The owner-stage of the new stage. 
           if(nargin == 4)
               obj = varargin{1};
                title = varargin{2};
                modality = varargin{3};
                ownerStage = varargin{4};
                stageHandle = obj.jfxApplication.createStage(title, modality, ownerStage);
            else
                msgID = 'EXCEPTION:IllegalArgument';
                msg = 'Illegal number of arguments.';
                throw(MException(msgID,msg));
            end
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
            if(obj.allStageControllers.containsKey(stageController.title))
               tmpList = obj.allStageControllers.get(stageController.title); 
               tmpList.add(stageController);
            else
                tmpList = List;
                tmpList.add(stageController);
                obj.allStageControllers.put(stageController.title, tmpList); 
            end
        end
        
        function removeStageController(obj, stageController) 
            % Removes a stageController from the collection of known
            % stageControllers. 
            % params:
            % obj:
            % stageController: StageController to be removed. 
            if(obj.allStageControllers.containsKey(stageController.title))
                obj.allStageControllers.get(stageController.title).remove(stageController); 
                if(obj.allStageControllers.get(stageController.title).isEmpty())
                    obj.allStageControllers.remove(stageController.title); 
                end
            end
        end
        
        function stageController = getStageControllerByTitle(obj, title)
            % Fetches all StageControllers with the given title. 
            % params:
            % obj: 
            % title: Title of the required StageController. 
            stageController = obj.allStageControllers.get(title); 
            if(isequal(stageController, -1)) 
                stageController = List();  
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

