classdef (Abstract) Controller < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        applicationController; 
        uiHandle;
        observable_h; 
    end
    
    methods
        function obj = Controller(applicationController, uiHandle) 
            obj.applicationController = applicationController; 
            obj.uiHandle = uiHandle;
            applicationController.registerController(obj);
            obj.observable_h = handle(uiHandle.getObservable(),'CallbackProperties');
            set(obj.observable_h, 'UiEventCallback', @(h,e)obj.notifyThis(e));
        end
        
        function notifyThis(obj, e) 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.unregisterListener();
                obj.applicationController.unregisterController(obj);
            elseif(obj.notify(e))
                % Do nothing. Event was handled by sub-class.
            else
               disp(['No callback registered.'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
            
        end
        
        function unregisterListener(obj) 
            set(obj.observable_h, 'UiEventCallback', '');
        end
    end
    
    methods (Abstract)
        eventConsumed = notify(obj, e)
    end
end

