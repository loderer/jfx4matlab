function startup()
    % Ben�tigte Klassen zum statischen Klassenpfad hinzuf�gen
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