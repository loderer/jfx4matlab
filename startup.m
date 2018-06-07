function startup()
    % Benötigte Klassen zum statischen Klassenpfad hinzufügen
    addpath('C:\Users\rudi\Documents\GitHub\jsonlab');
    addpath('C:\Users\rudi\Documents\GitHub\BaMatlab\extLib');
    addpath('C:\Users\rudi\Documents\GitHub\BaMatlab\jfx');
    addpath('C:\Users\rudi\Documents\GitHub\BaMatlab\model');
    addpath('C:\Users\rudi\Documents\GitHub\BaMatlab\model\person');
    addpath('C:\Users\rudi\Documents\GitHub\BaMatlab\sceneController');
    javaaddpathstatic(['C:\Program Files\MATLAB\R2015b\sys\java\jre\win64\jre\lib\jfxrt.jar']);
    javaaddpathstatic(['C:\Users\rudi\Documents\GitHub\BaJavaFx\out\artifacts\JavaFxSample_jar\JavaFxSample.jar']);
   
    model = Model();
    
    app = JFXApp('sample_app.Main');
    overviewStageController = JFXStageController('Phone book', app);
    overviewSceneController = OverviewController('sample/overview.fxml', model);
    overviewStageController.showScene(overviewSceneController, 510, 500);