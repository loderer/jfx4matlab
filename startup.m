function startup()
    % Benötigte Klassen zum statischen Klassenpfad hinzufügen
   javaaddpathstatic(['C:\Program Files\MATLAB\R2015b\sys\java\jre\win64\jre\lib\jfxrt.jar']);
   javaaddpathstatic(['C:\Users\rudi\Documents\GitHub\BaJavaFx\out\production\JavaFxSample']);
   
    % GUI starten
   jfxMain = javaObject('sample_app.Main');
   primaryStageObservable = jfxMain.startGuiThread('');
   
   applicationController = ApplicationController(primaryStageObservable);
   
   uiHandle = jfxMain.showScene('sample/sample.fxml');
   
   % Callbacks registrieren
   sampleController = SampleController(uiHandle); 
   applicationController.registerController(sampleController);
   
   disp(''); 