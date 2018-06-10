classdef OverviewListController < JFXSceneController
    %OverviewListController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        model; 
        
        % ui elements
        list; 
    end
    
    methods
        function obj = OverviewListController(pathToFxml, model) 
            obj = obj@JFXSceneController(pathToFxml);
            obj.model = model; 
        end
        
        function initScene(obj)
            % fetch ui elements
            obj.list = obj.getUiElement('list');
            
            % fill list
            obj.pushBackTask(obj.list, 'setCellFactory', sample_app.JsonListCellValueFactory('surname'));
            data = javafx.collections.FXCollections.observableArrayList();
            for n = 1:size(obj.model.person, 2)
                data.add(java.lang.String(savejson('', obj.model.person{1, n})));
            end
            obj.pushBackTask(obj.list, 'setItems', data);
            
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
            elseif(strcmp(e.fxId, 'btn_switchToTable')...
                    && strcmp(e.action, 'ACTION'))
                obj.btn_switchToTablePressed(); 
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_switchToPlot')...
                && strcmp(e.action, 'ACTION'))
                obj.btn_switchToPlotPressed();
                eventConsumed = 1;
            end
        end
        
        function btnNewEntryPressed(obj)
            detailStageController = JFXStageController('Detail', obj.getJfxApp());
            detailSceneController = DetailController('sample/detail.fxml', obj.model, obj);
            detailStageController.showScene(detailSceneController, 500, 250);
        end
        
        function btn_editEntryPressed(obj)
            selectionModel = obj.applyTask(obj.list, 'getSelectionModel'); 
            selectedItem = selectionModel.getSelectedItem();
            if(~isempty(selectedItem))
                person = loadjson(selectedItem); 
            
                detailStageController = JFXStageController('Detail', obj.getJfxApp());
                detailSceneController = DetailController('sample/detail.fxml', obj.model, obj, person);
                detailStageController.showScene(detailSceneController, 200, 146);
            else
                disp('Select item!!!');
            end
        end
        
        function btn_savePressed(obj) 
            obj.model.writeJson();
        end
        
        function btn_switchToTablePressed(obj)
            overviewController = OverviewController('sample/overview.fxml', obj.model);
            obj.stageController.showScene(overviewController, 510, 500);
        end
        
        function btn_switchToPlotPressed(obj)
            plotController = PlotController('sample/plot.fxml', obj.model);
            obj.stageController.showScene(plotController, 510, 500);
        end
        
        function update(obj, oldItem, newItem) 
            data = obj.applyTask(obj.list, 'getItems');
            if(oldItem.id ~= -1) 
                obj.applyTask(data, 'remove', java.lang.String(savejson('', oldItem)));
            end
            obj.applyTask(data, 'add', java.lang.String(savejson('', newItem)));
        end
    end
end
