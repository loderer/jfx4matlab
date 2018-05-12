function startup()
    % Benötigte Klassen zum statischen Klassenpfad hinzufügen
   javaaddpathstatic(['C:\Program Files\MATLAB\R2015b\sys\java\jre\win64\jre\lib\jfxrt.jar']);
   javaaddpathstatic(['C:\Users\rudi\Documents\GitHub\BaJavaFx\out\production\JavaFxSample']);
   
    % GUI starten
   jfxMain = javaObject('sample.Main');
   jfxMain.startGui('');
   
   % JFxThread
   jfxThread = jfxMain.getJfxThread(); 
   
   % Callbacks registrieren
   observer = Observer(jfxThread);
   observable_h = handle(jfxMain.getObservable(),'CallbackProperties');
   set(observable_h, 'UiEventCallback', @(h,e)observer.notify(e));
   
   disp(''); 
   