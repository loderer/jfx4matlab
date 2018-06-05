classdef OverviewController < JFXSceneController
    %OverviewController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        model; 
        
        % ui elements
        tableColumnName;
        tableColumnSurname; 
        table;
    end
    
    methods
        function obj = OverviewController(pathToFxml, model) 
            obj = obj@JFXSceneController(pathToFxml);
            obj.model = model; 
        end
        
        function initScene(obj)
            % fetch ui elements
            obj.tableColumnName = obj.getUiElement('tableColumnName');
            obj.tableColumnSurname = obj.getUiElement('tableColumnSurname');
            obj.table = obj.getUiElement('table');
            
            % Fill table.
            obj.pushBackTask(obj.tableColumnName, 'setCellValueFactory', sample_app.JsonCellValueFactory('name')); 
            obj.pushBackTask(obj.tableColumnSurname, 'setCellValueFactory', sample_app.JsonCellValueFactory('surname')); 
            data = javafx.collections.FXCollections.observableArrayList();
            for n = 1:size(obj.model.person, 2)
                data.add(java.lang.String(savejson('', obj.model.person{1, n})));
            end
            obj.pushBackTask(obj.table, 'setItems', data);
            
            obj.applyTasks();
        end
        
        function eventConsumed = onSceneAction(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'btn_newEntry')...
                    && strcmp(e.action, 'ACTION'))
                obj.btnNewEntryPressed();
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_editEntry')... 
                        && strcmp(e.action, 'ACTION'))
                obj.btn_editEntryPressed();
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_save')...
                    && strcmp(e.action, 'ACTION'))
                obj.btn_savePressed();
                eventConsumed = 1;
            end
        end
        
        function btnNewEntryPressed(obj)
            detailStageController = JFXStageController('Detail', obj.getJfxApp());
            detailSceneController = DetailController('sample/detail.fxml', obj.model, obj);
            detailStageController.showScene(detailSceneController, 500, 250);
        end
        
        function btn_editEntryPressed(obj)
            selectionModel = obj.applyTask(obj.table, 'getSelectionModel'); 
            selectedItem = selectionModel.getSelectedItem();
            if(~isempty(selectedItem))
                person = loadjson(selectedItem); 
            
                detailStageController = JFXStageController('Detail', obj.getJfxApp());
                detailSceneController = DetailController('sample/detail.fxml', obj.model, obj, person);
                detailStageController.showScene(detailSceneController, 500, 250);
            else
                disp('Select item!!!');
            end
        end
        
        function btn_savePressed(obj) 
            obj.model.writeJson();
        end
        
        function update(obj, oldItem, newItem) 
            data = obj.applyTask(obj.table, 'getItems');
            if(oldItem.id ~= -1) 
                data.remove(java.lang.String(savejson('', oldItem)));
            end
            data.add(java.lang.String(savejson('', newItem)));
        end
    end
end
