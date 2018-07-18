# Nutzen mehrerer Scenen
Die meisten Applikationen bestehen aus mehr als einer Scene. Oftmals wird von von einer Startseite auf verschiedene Scenen mit spezifischen Aufgaben umgeleitet. Dabei werden die Scenen entweder in einem neuen Fenster geöffent, oder ersetzen die Startseite. Beide Fälle, sowohl das öffnen eines weiteren Fensters, als auch das ersetzen einer Scene, sollen im Folgenden anhand eines Beispiels abgearbeitet werden.

Das Beispiel basiert auf der [Hello World Anwendung](../../samples/HelloWorld) und erweitert diese um eine Startseite. (Die Scene der [Hello World Anwendung](../../samples/HelloWorld) wird im Folgenden mit Sample-Scene bezeichnet.) Die Startseite erlaubt dem Benutzer die Wahl, ob er die Startseite durch die Sample-Scene ersetzen will oder ob er die Sample-Scene in einem neuen Fenster öffnen will.

Zuerst erschaffen wir die fxml-Datei der Startseite.
```xml
<?xml version="1.0" encoding="UTF-8"?>

<?import javafx.scene.control.Button?>
<?import javafx.scene.layout.VBox?>

<VBox xmlns="http://javafx.com/javafx/8.0.65" xmlns:fx="http://javafx.com/fxml/1" fx:controller="generic_jfx_application.event_transfer.Controller">
   <children>
      <Button fx:id="btn_openInOtherWindow" maxHeight="1.7976931348623157E308" maxWidth="1.7976931348623157E308" mnemonicParsing="false" onAction="#handleEvent" text="open scene in another window" VBox.vgrow="ALWAYS" />
      <Button fx:id="btn_openInThisWindow" maxHeight="1.7976931348623157E308" maxWidth="1.7976931348623157E308" mnemonicParsing="false" onAction="#handleEvent" text="open scene in this window" VBox.vgrow="ALWAYS" />
   </children>
</VBox>
```
Diese enthält zwei Buttons. Beiden wurde ein Identifier und ein sprechender Text zugewiesen. Das Action-Event beider Buttons wird an das jfx4matlab-Package weitergeleitet. Folgender Controller erbt von der JFXSceneController-Klasse und verarbeitet die Action-Events.
```MATLAB
classdef StarterController < jfx4matlab.matlab.JFXSceneController
    %STARTERCONTROLLER Controller class for the starter scene.

    methods
        function obj = StarterController(fxml)
            obj = obj@jfx4matlab.matlab.JFXSceneController(fxml);
        end

        function eventConsumed = handleSceneEvent(obj, e)
            eventConsumed = 0;

            % Determine path to sample.fxml
            [pathToThisDir, ~, ~] = fileparts(mfilename('fullpath'));
            pathToFxml = fullfile(pathToThisDir, 'sample.fxml');

            if(strcmp(e.fxId, 'btn_openInOtherWindow')...
                    && strcmp(e.action, 'ACTION'))
                obj.openSampleInOtherWindow(pathToFxml);
                eventConsumed = 1;
            elseif(strcmp(e.fxId, 'btn_openInThisWindow')...
                    && strcmp(e.action, 'ACTION'))
                obj.openSampleInThisWindow(pathToFxml);
                eventConsumed = 1;
            end
        end

        function openSampleInOtherWindow(obj, pathToFxml)
            % Create stage
            stageController = jfx4matlab.matlab.JFXStageController(...
                obj.getJfxApplication(), 'Hello World');
            % Create scene
            sceneController = SampleController(pathToFxml);
            stageController.showScene(sceneController);
        end

        function openSampleInThisWindow(obj, pathToFxml)
            % Create scene
            sceneController = SampleController(pathToFxml);
            obj.getStageController().showScene(sceneController);
        end
    end
end
```
Die Funktion "openSampleInOtherWindow" erzeugt ein neues Fenster (eine neue Stage). Die Sample-Scene wird in diesem neuen Fenster geöffnet. Die Funktion "openSampleInThisWindow" hingegen, öffnet die Sample-Scene auf der Stage der Startseite. Die Stage wird dabei über eine Methode der Basisklasse JFXSceneController ermittelt.

Im Start-Skript der Anwendung muss nun noch die Scene der Startseite anstatt der Sample-Scene instanziiert werden.
```Matlab
% Add required directories to classpath.-----------------------------------

% Get the path to the folder containing this file.
[pathToThisDir, ~, ~] = fileparts(mfilename('fullpath'));
% Add all MATLAB-sources to the class path.
addpath(genpath(pathToThisDir));
% Add MATLAB-library to class path.
jfx4matlabPath = fullfile(pathToThisDir, '..', '..');
addpath(jfx4matlabPath);
import jfx4matlab.matlab.*;
%--------------------------------------------------------------------------

% Get the path to the fxml.
pathToFxml = fullfile(pathToThisDir, 'starter.fxml');

% Create javaFX-application.
jfxApplication = JFXApplication();

% Create stage. Change the title to indicate the use different windows.
stageController = JFXStageController(jfxApplication, 'Hello World Starter');
% Create scene
% sceneController = SampleController(pathToFxml);
sceneController = StarterController(pathToFxml);
stageController.showScene(sceneController);
```

Nach dem Start der Applikation öffnet sich dieses Fenster.

![Screenshot der gestarteten Anwendung.](SampleApplication_I.png)

Klickt man auf den Button "open scenen in another window", so öffnet sich ein weiteres Fenster.

![Screenshot der gestarteten Anwendung.](SampleApplication_II.png)

Ein Klick auf den Button "open scene in this window" hat ein Verdrängen der Startseite zur Folge.

![Screenshot der gestarteten Anwendung.](SampleApplication_III.png)

Der Sourcecode dieses Beispiels befindet sich in [diesem Ordner](../../samples/MultipleScenes). Zum Ausführen des Beispiels muss das gesamte Repository ausgecheckt werden! Die Ordnerstruktur darf nicht verändert werden!
