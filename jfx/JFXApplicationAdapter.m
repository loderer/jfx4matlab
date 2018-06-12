classdef JFXApplicationAdapter < handle
    %JFXApplicationAdapter Wraps the JFXApplication and its functionality. 
    %   This class allows easy access to the functions of the java class 
    %   JFXApplication. 
    
    properties (Access=private)
        jfxApplication; % The JFXApplication object (java).
        wasPrimaryStageCreated; % A flag indicating if the primary stage still has been created. 
    end
    
    methods
        function obj = JFXApplicationAdapter(pathToJfxApplication)
            obj.jfxApplication = javaObject(pathToJfxApplication);
            obj.wasPrimaryStageCreated = 0; 
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
                    stageHandle = obj.jfxApplication.startGuiThread(title);
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
                obj, stage, pathToFxml, width, height) 
            % Propagates the specified scene on the stage. 
            % params: 
            % obj
            % stage: The stage the scene should be propergated on. 
            % pathToFxml: The scenes fxml file. 
            % width: Width of the scene. 
            % height: Height of the scene. 
            sceneHandle = obj.jfxApplication.showScene(...
                stage, pathToFxml, width, height);
        end
    end
    
end

