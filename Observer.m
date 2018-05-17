classdef Observer
    %OBSERVER An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        uiHandle;
        observable_h; 
    end
    
    methods
        function obj = Observer(uiHandle) 
            obj.uiHandle = uiHandle;
            obj.observable_h = handle(uiHandle.getObservable(),'CallbackProperties');
            set(obj.observable_h, 'UiEventCallback', @(h,e)obj.notify(e));
        end
        
        function notify(obj, e) 
            if(strcmp(e.controller, 'package.class')...
                    && strcmp(e.fxId, 'fxId')...
                    && strcmp(e.action, 'action'))
                % TODO
            elseif(strcmp(e.controller, 'sample_app.sample.SampleController')...
                    && strcmp(e.fxId, 'button')...
                    && strcmp(e.action, 'ACTION'))
                obj.uiHandle.applyTask('label', 'setTextFill', javafx.scene.paint.Color.BLUE);
            elseif(strcmp(e.controller, 'root')...
                    && strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                % primaryStage geschlossen -> Listener abmelden
                set(obj.observable_h, 'UiEventCallback', '');
            else
               disp(['No callback registered.'...
                    ' (controller: ' char(e.controller)...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
    end
end
