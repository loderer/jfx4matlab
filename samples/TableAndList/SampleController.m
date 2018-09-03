classdef SampleController < jfx4matlab.matlab.JFXSceneController
    %SAMPLECONTROLLER Controller class for the sample scene.
    
    properties
        table; 
        tc_I;
        tc_II;
        list; 
        label;
    end
    
    methods
        function obj = SampleController(fxml)
            obj = obj@jfx4matlab.matlab.JFXSceneController(fxml);
        end
        
        function initScene(obj)
            obj.table = obj.getUiElement('table'); 
            obj.tc_I = obj.getUiElement('tc_I');
            obj.tc_II = obj.getUiElement('tc_II');
            obj.list = obj.getUiElement('list');
            obj.label = obj.getUiElement('label');
            
            % init tabel
            obj.pushBackTask(obj.tc_I, 'setCellValueFactory', generic_jfx_application.cell_value_factory.JsonTableCellValueFactory('tc_I')); 
            obj.pushBackTask(obj.tc_II, 'setCellValueFactory', generic_jfx_application.cell_value_factory.JsonTableCellValueFactory('tc_II')); 
            % prepare content
            tableItemI = struct(...
                'name', 'tableitem I',...
                'tc_I', 'tableitem I column I',...
                'tc_II', 'tableitem I column II'); 
            tableItemII = struct(...
                'name', 'tableitem II',...
                'tc_I', 'tableitem II column I',...
                'tc_II', 'tableitem II column II'); 
            % set content
            data = javafx.collections.FXCollections.observableArrayList();
            data.add(java.lang.String(mls.internal.toJSON(tableItemI)));
            data.add(java.lang.String(mls.internal.toJSON(tableItemII)));
            obj.pushBackTask(obj.table, 'setItems', data);
            
            % init list
            obj.pushBackTask(obj.list, 'setCellFactory', generic_jfx_application.cell_value_factory.JsonListCellValueFactory('name')); 
            % prepare content
            listItemI = struct(...
                'name', 'listitem I',...
                'garbage', 'lorem ipsum');
            listItemII = struct(...
                'name', 'listitem II',...
                'garbage', 'lorem ipsum');
            % set content
            data = javafx.collections.FXCollections.observableArrayList();
            data.add(java.lang.String(mls.internal.toJSON(listItemI)));
            data.add(java.lang.String(mls.internal.toJSON(listItemII)));
            obj.pushBackTask(obj.list, 'setItems', data);
            
            obj.applyTasks(); 
        end
        
        function eventConsumed = handleSceneEvent(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'table')...
                    && strcmp(e.action, 'MOUSE_CLICKED'))
                % handle click in table
                selectionModel = obj.applyTask(obj.table, 'getSelectionModel'); 
                selectedItem = selectionModel.getSelectedItem();
                if(~isempty(selectedItem))
                    item = mls.internal.fromJSON(selectedItem);
                    obj.applyTask(obj.label, 'setText', item.name);
                end
                eventConsumed = 1;
            elseif(strcmp(e.fxId, 'list')...
                    && strcmp(e.action, 'MOUSE_CLICKED'))
                % handle click in list
                selectionModel = obj.applyTask(obj.list, 'getSelectionModel'); 
                selectedItem = selectionModel.getSelectedItem();
                if(~isempty(selectedItem))
                    item = mls.internal.fromJSON(selectedItem);
                    obj.applyTask(obj.label, 'setText', item.name);
                end
                eventConsumed = 1;
            end
        end
    end
end

