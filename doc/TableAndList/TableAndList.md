# Fill tables and lists
To use a table or a list you have to add a TableView with some columns or a ListView to a scene. Each of this elements must have a dedicated identifier. The following example assumes that
- the TableView has the identifier "table".
- the first column of the table is named "tc_I".
- the second column of the table is named "tc_II".
- the ListView is named "list".
- there is a Label with the identifier "label".

If the above mentioned conditions are met you can init the table and list like this.

```matlab
function initScene(obj)
    obj.table = obj.getUiElement('table');
    obj.tc_I = obj.getUiElement('tc_I');
    obj.tc_II = obj.getUiElement('tc_II');
    obj.list = obj.getUiElement('list');
    obj.label = obj.getUiElement('label');

    % init table
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
```

## Init a table
Each line of a table corresponds to a json-object. To specify which  attribute of the json-object should be shown in a column you have to set a JsonTableCellValueFactory on each of them. This factories expect a string-parameter. This parameter specifies the name of the attribute to be shown.

## Init a list
A list is handled like a table with one column. That's why you only have to set one JsonListCellValueFactory.


<b>Watch out!</b> - The methods to set a JsonTableCellValueFactory and to set a JsonListCellValueFactory are slightly different.

An example using tables and scenes is available [here](../../samples/TableAndList). To run the example, you have to check out the whole repository! The structure of the folders must not be changed!
