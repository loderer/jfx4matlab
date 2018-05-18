classdef (Abstract) Controller < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
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
    end
    
    methods (Abstract)
        notify(obj, e)
    end
end

