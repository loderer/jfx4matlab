classdef PlotController < JFXSceneController
    %PLOTCONTROLLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        model; 
        actSeries;
        
        % ui elements
        lineChart; 
        db_function; 
    end
    
    methods
        function obj = PlotController(pathToFxml, model) 
            obj = obj@JFXSceneController(pathToFxml);
            obj.model = model; 
            obj.actSeries = -1;
        end
        
        function initScene(obj)
            % fetch ui elements
            obj.lineChart = obj.getUiElement('lineChart');
            obj.db_function = obj.getUiElement('db_function');
            
            data = javafx.collections.FXCollections.observableArrayList();
            data.add('x');
            data.add('1');
            obj.pushBackTask(obj.db_function, 'setItems', data);
            obj.pushBackTask(obj.db_function.getSelectionModel(), 'selectFirst');
            obj.applyTasks(); 
            obj.plotFunction('x'); 
        end
        
        function plotFunction(obj, costumFunction)
            if(obj.actSeries ~= -1) 
                obj.applyTask(obj.lineChart.getData(), 'remove', obj.actSeries); 
            end
            
            obj.actSeries = javaObject('javafx.scene.chart.XYChart$Series');
            obj.actSeries.setName('function');
            for x = 1:10
                obj.actSeries.getData().add(javaObject('javafx.scene.chart.XYChart$Data', x, eval(costumFunction)));
            end
            obj.applyTask(obj.lineChart.getData(), 'add', obj.actSeries); 
        end
        
        function eventConsumed = onSceneAction(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'btn_switchToTable')...
                    && strcmp(e.action, 'ACTION'))
                overviewController = OverviewController('sample/overview.fxml', obj.model);
                obj.stageController.showScene(overviewController, 510, 500);
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_switchToList')...
                    && strcmp(e.action, 'ACTION'))
                overviewListController = OverviewListController('sample/overviewList.fxml', obj.model);
                obj.stageController.showScene(overviewListController, 510, 500);
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_apply')...
                && strcmp(e.action, 'ACTION'))
                obj.plotFunction(java.lang.String(obj.db_function.getSelectionModel().getSelectedItem())); 
                eventConsumed = 1; 
            end
        end
    end
    
end

