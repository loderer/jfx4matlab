classdef ControllerOverview < Controller
    %ControllerOverview An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        jfxMain; 
    end
    
    methods
        function obj = ControllerOverview(uiHandle, jfxMain) 
            obj = obj@Controller(uiHandle);
            obj.jfxMain = jfxMain; 
        end
        
        function notify(obj, e) 
            if(strcmp(e.fxId, 'btn_newEntry')...
                    && strcmp(e.action, 'ACTION'))
                obj.btnNewEntryPressed();
            else
               disp(['No callback registered.'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
        
        function btnNewEntryPressed(obj) 
            obj.jfxMain.showScene('sample/detail.fxml');
        end
    end
end
