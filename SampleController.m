classdef SampleController < Controller
    %SampleController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
    end
    
    methods
        function obj = SampleController(uiHandle) 
            obj = obj@Controller(uiHandle);
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
