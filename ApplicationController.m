classdef ApplicationController < handle
    %ApplicationController Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        primaryStageObservable_h;
        controllers;
    end
    
    methods
        function obj = ApplicationController(primaryStageObservable_h) 
            obj.primaryStageObservable_h = handle(primaryStageObservable_h,'CallbackProperties');
            set(obj.primaryStageObservable_h, 'UiEventCallback', @(h,e)obj.notify(e));
            obj.controllers = {};
        end
        
        function notify(obj, e) 
            if(strcmp(e.fxId, 'root')...
                    && strcmp(e.action, 'CLOSE'))
                obj.unregisterAll();
            else
               disp(['No callback registered.'...
                    ' fxId: ' char(e.fxId)...
                    ' action: ' char(e.action) ')']);
            end
        end
        
        function registerController(obj, controller) 
            pos = size(obj.controllers, 2) + 1; 
            obj.controllers{pos} = controller;
        end
        
        function unregisterAll(obj) 
            for n = 1:size(obj.controllers, 1)
               obj.controllers{n}.unregister(); 
            end
            
            set(obj.primaryStageObservable_h, 'UiEventCallback', '');
            
            obj.controllers = {};
        end
        
    end
    
end

