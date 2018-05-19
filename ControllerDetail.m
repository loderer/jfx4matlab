classdef ControllerDetail < Controller
    %CONTROLLERDETAIL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = ControllerDetail(applicationController,... 
                uiHandle) 
            obj = obj@Controller(applicationController, uiHandle);
        end
        
        function eventConsumed = notify(~, ~) 
            eventConsumed = 0;
        end
    end
    
end

