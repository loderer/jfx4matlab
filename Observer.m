classdef Observer
    %OBSERVER An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        jfxThread
    end
    
    methods
        function obj = Observer(jfxThread) 
            obj.jfxThread = jfxThread;
        end
        
        function notify(~, e) 
            if(strcmp(e.controller, 'package.class')...
                    && strcmp(e.fxId, 'fxId')...
                    && strcmp(e.action, 'action'))
                % TODO
            else
               disp(['No callback registered.'...
                    ' (controller: ' char(e.controller)...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
    end
end
