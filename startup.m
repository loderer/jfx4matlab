function startup()
    % Ben�tigte Klassen zum statischen Klassenpfad hinzuf�gen
   javaaddpathstatic(['C:\Program Files\MATLAB\R2015b\sys\java\jre\win64\jre\lib\jfxrt.jar']);
   javaaddpathstatic(['C:\Users\rudi\Documents\GitHub\BaJavaFx\out\production\JavaFxSample']);
   
    app = JFXApp('sample_app.Main');
    overviewStageController = JFXStageController('myWindowTitle', app);
    overviewSceneController = OverviewController('sample/overview.fxml');
    overviewStageController.showScene(overviewSceneController);