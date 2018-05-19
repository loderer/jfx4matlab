classdef ControllerOverview < Controller
    %ControllerOverview An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        jfxMain; 
    end
    
    methods
        function obj = ControllerOverview(applicationController,... 
                uiHandle, jfxMain) 
            obj = obj@Controller(applicationController, uiHandle);
            obj.jfxMain = jfxMain; 
        end
        
        function eventConsumed = notify(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'btn_newEntry')...
                    && strcmp(e.action, 'ACTION'))
                obj.btnNewEntryPressed();
                eventConsumed = 1; 
            end
        end
        
        function btnNewEntryPressed(obj) 
            obj.jfxMain.showScene('sample/detail.fxml');
        end
    end
end
