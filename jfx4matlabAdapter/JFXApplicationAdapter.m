classdef JFXApplicationAdapter < handle
    %JFXApplicationAdapter Wraps the JFXApplication and its functionality. 
    %   This class allows easy access to the functions of the java class 
    %   JFXApplication. 
    
    properties (Access=private)
        jfxApplication; % The JFXApplication object (java).
        wasPrimaryStageCreated; % A flag indicating if the primary stage still has been created. 
        allStageControllers; % All existing stageController grouped by name. 
    end
    
    methods
        function obj = JFXApplicationAdapter(varargin)
            % params:
            % pathToJfxApplication: The path to the java class
            % JFXApplication. 
            % (optional) enableTestMode: Enable test mode?
            
            % Add required libs to path.
            javaaddpathstatic(Config.jfxrtPath);
            javaaddpathstatic(Config.jfx4matlabPath);
            
            pathToJfxApplication = varargin{1}; 
            obj.jfxApplication = javaObject(pathToJfxApplication);
            if(nargin > 1) 
                enableTestMode = varargin{2};
                if(enableTestMode) 
                    obj.jfxApplication.enableTestMode(); 
                end
            end
            obj.wasPrimaryStageCreated = 0; 
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
            % (optional) parentStageController: This parameter is only 
            % necessary if the new stage should behave modal. 
            obj = varargin{1};
            title = varargin{2};
            if(nargin == 2)
                % create non-modal stage
                if(~obj.wasPrimaryStageCreated) 
                    stageHandle = obj.jfxApplication.startGuiAsynchronous(title);
                    obj.wasPrimaryStageCreated = 1; 
                else
                    stageHandle = obj.jfxApplication.newStage(title);
                end
            elseif(nargin == 3)
                % create modal stage
                parentStageController = varargin{3};
                if(~obj.wasPrimaryStageCreated) 
                    msgID = 'EXCEPTION:IllegalState';
                    msg = 'Primary stage can not be modal.';
                    throw(MException(msgID,msg));
                else
                    stageHandle = obj.jfxApplication.newStage(title, parentStageController.stage);
                end
            else
                disp('Incorrect number of arguments!!!');
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

