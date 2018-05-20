classdef PrimaryStageController < StageController
    %ABSPRIMARYSTAGECONTROLLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        stageControllers;
    end
    
    methods
        function obj = PrimaryStageController(stageHandle) 
            obj = obj@StageController(stageHandle);
            obj.stageControllers = {};
        end
        
        function notifyThis(obj, e) 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.unregisterSceneController(); 
                obj.unregisterAllStageControllers; 
            elseif(obj.notify(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
        
        function registerStageController(obj, stageController) 
            pos = size(obj.stageControllers, 2) + 1; 
            obj.stageControllers{pos} = stageController;
        end
        
        function unregisterStageController(obj, stageController)
            for n = 1:size(obj.controllers, 1)
               if(eq(stageController, obj.stageControllers{n}))
                    obj.stageControllers{n} = -1;
               end
            end
        end
        
        function unregisterAllStageControllers(obj) 
            for n = 1:size(obj.stageControllers, 1)
                if(obj.stageControllers{n} ~= -1)
                    obj.stageControllers{n}.unregisterListener(); 
                    obj.stageControllers{n}.unregisterSceneController(); 
                end 
            end
            
            set(obj.stageObservable_h, 'UiEventCallback', '');
            
            obj.stageControllers = {};
        end
    
        function eventConsumed = notify(~, ~)
            eventConsumed = 0;
        end
        
    end
end

