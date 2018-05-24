function startup()
    % Benötigte Klassen zum statischen Klassenpfad hinzufügen
   javaaddpathstatic(['C:\Program Files\MATLAB\R2015b\sys\java\jre\win64\jre\lib\jfxrt.jar']);
   javaaddpathstatic(['C:\Users\rudi\Documents\GitHub\BaJavaFx\out\production\JavaFxSample']);
   
    % GUI starten
   jfxMain = javaObject('sample_app.Main');
   primaryStageHandle = jfxMain.startGuiThread('');
   
   primaryStageController = PrimaryStageController(primaryStageHandle);
   
   sceneHandleOverview = jfxMain.showScene(primaryStageController.stage, 'sample/overview.fxml');
   
   % Callbacks registrieren
   ControllerOverview(primaryStageController,...
        sceneHandleOverview, jfxMain); 
   
   disp(''); 
   
% app = JFXApp('sample_app.Main');
% stageController = JFXStageController('myWindowTitle');
% app.setPrimaryStageController(stageController);
% sceneController = JFXSceneController('sample/overview.fxml');
% stageController.showScene(sceneController);

% secondStageController = JFXStageController('secondWindowsTitle', stageController);
% secondSceneController = JFXSceneController('sample/detail.fxml');
% secondStageController.showScene(secondSceneController);

% onAction = @(event) {
%   display('HelloWorld');
% }
% secondSceneControlle.addNotify('btn_newEntry', 'ACTION', onAction);