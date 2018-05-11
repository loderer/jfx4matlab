classdef Observer
    %CONTROLLERADAPTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function notify(obj, e) 
            if(strcmp(e.fxId, 'PLOT_FUNCTIONS_CB') && strcmp(e.action, 'ON_CLICK'))
                obj.togglePlotFunctions(controller);
            else
               disp('No callback registered.');
            end
        end
    end
end
