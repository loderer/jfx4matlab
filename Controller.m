classdef Controller
    %Controller An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        uiHandle;
        observable_h; 
    end
    
    methods
        function obj = Controller(uiHandle) 
            obj.uiHandle = uiHandle;
            obj.observable_h = handle(uiHandle.getObservable(),'CallbackProperties');
            set(obj.observable_h, 'UiEventCallback', @(h,e)obj.notify(e));
        end
        
        function unregister(obj) 
            set(obj.observable_h, 'UiEventCallback', '');
        end
        
        function notify(obj, e) 
            if(strcmp(e.fxId, 'fxId')...
                    && strcmp(e.action, 'action'))
                % TODO
            elseif(strcmp(e.fxId, 'button')...
                    && strcmp(e.action, 'ACTION'))
                obj.uiHandle.applyTask('label', 'setTextFill', javafx.scene.paint.Color.BLUE);
            else
               disp(['No callback registered.'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
    end
end
