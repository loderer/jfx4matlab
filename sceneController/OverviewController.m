classdef OverviewController < JFXSceneController
    %OverviewController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
    end
    
    methods
        function obj = OverviewController(pathToFxml) 
            obj = obj@JFXSceneController(pathToFxml);
        end
        
        function initScene(obj)
            array = javaArray('java.lang.String', 2);
            array(1) = java.lang.String(savejson('', Person('Rudi', 'Loderer')));
            array(2) = java.lang.String(savejson('', Person('Anna-Maria', 'Schlatterer')));
            data = javaMethod('observableArrayList', 'javafx.collections.FXCollections',...
                array);
            
            obj.pushBackTask('tableColumnName', 'setCellValueFactory', sample_app.JsonCellValueFactory('name')); 
            obj.pushBackTask('tableColumnSurname', 'setCellValueFactory', sample_app.JsonCellValueFactory('surname')); 
            obj.pushBackTask('table', 'setItems', data);
%             obj.pushBackTask(
            
            obj.applyTasks();
        end
        
        function eventConsumed = onSceneAction(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'btn_newEntry')...
                    && strcmp(e.action, 'ACTION'))
                obj.btnNewEntryPressed();
                eventConsumed = 1; 
            end
        end
        
        function btnNewEntryPressed(obj)
            detailStageController = JFXStageController('Detail', obj.getJfxApp());
            detailSceneController = DetailController('sample/detail.fxml');
            detailStageController.showScene(detailSceneController, 500, 250);
        end
    end
end
