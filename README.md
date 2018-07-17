# jfx4matlab
jfx4matlab ermöglicht das Umsetzen einer MATLAB-Anwendung mit JavaFX-Benutzeroberfläche, ohne eine Java-Klasse implementieren zu müssen. Zusätzlich zur Integration von JavaFX erlaubt das jfx4matlab-Package das Testen der GUI-Logik.  
## Hello World
Wie das jfx4matlab-Package zu verwenden ist wird im Folgenden am Beispiel einer einfachen Anwendung erläutert.

Im initialen Zustand gleicht die Anwendung dem Folgenden Screenshot.  

![Screenshot einer einfachen Anwendung vor klicken des Buttons.](/docResources/SampleApplication_before.png)

Nach einem Klick auf den Button mit dem Text "click me" wird "Hello World!!!" durch "heureka" ersetzt. Folgender Screenshot visualisiert das Aussehen nach einem Klick.

![Screenshot einer einfachen Anwendung nach klicken des Buttons.](/docResources/SampleApplication_after.png)

### Begriffserklärung
Jedes Fenster einer Anwendung ist in zwei Teile aufgeteilt. Der Inhalt des Fensters wird Scene genannt. Ein weiterer Teil ist der Rahmen um den Inhalt. Das ist die Stage. Sie beinhaltet ein Icon, den Titel und die Buttons zum minnimieren, maximieren und schließen des Fensters.

![Screenshot zum visualisieren der Unterteilung eines Fensters in Stage und Scene.](/docResources/SceneAndStage.png)


### Schritt für Schritt Anleitung
#### Ein erster Prototyp
Zum Implementieren eines ersten Prototyps müssen lediglich zwei Dateien implementiert werden. Die erste ist folgende fxml-Datei.
```xml
<?xml version="1.0" encoding="UTF-8"?>

<?import javafx.scene.control.Button?>
<?import javafx.scene.control.Label?>
<?import javafx.scene.layout.VBox?>

<VBox xmlns="http://javafx.com/javafx/8.0.65" xmlns:fx="http://javafx.com/fxml/1">
   <children>
      <Label alignment="TOP_LEFT" maxHeight="1.7976931348623157E308" maxWidth="1.7976931348623157E308" text="Hello world!!!" VBox.vgrow="ALWAYS" />
      <Button maxWidth="1.7976931348623157E308" mnemonicParsing="false" text="click me" />
   </children>
</VBox>
```
Ihr Inhalt definiert den Content und das Layout der Scene. In unserer Fall wird eine  Vertical-Box mit einem Label und einem Button hinzugefügt. Das Label nimmt dabei immer den gesamten verfügbaren Platz, sowohl in vertikale, als auch in horizontale Richtung ein. Der Text des Labels lautet "Hello World!!!". Der Button ist am unteren Rand des Fensters fixiert und nimmt den gesamten verfügbaren Platz in horizontale Richtung ein. Sein Text lautet "click me".   

Zusätzlich zur fxml-Datei wird für den Prototypen folgendes MATLAB-Skript benötigt.  
```Matlab
% Add required directories to classpath.-----------------------------------

% Add MATLAB-library to class path.
addpath(<PATH_TO_THE_JFX4MATLAB_PACKAGE>);
import jfx4matlab.matlab.*;
%--------------------------------------------------------------------------

% Create javaFX-application.
jfxApplication = JFXApplication();

% Create stage.
stageController = JFXStageController(jfxApplication, 'Hello World');
% Create scene
sceneController = JFXSceneController(<PATH_TO_THE_FXML_FILE>);
stageController.showScene(sceneController);
```
Es fügt das jfx4matlab-Package zum Pfad hinzu. Dann instanziiert es die JFXApplication-Klasse des jfx4matlab-Packages. Diese Klasse verwaltet alle Fenster. Dannach wird mithilfe der vordefinierten Klassen JFXStageController und JFXSceneController, eine Stage und eine Scene erzeugt. Die Scene wird dabei aus der zuvor definierten fxml-Datei generiert. Als letztes muss die Scene auf der Stage publiziert werden.  

Ein ausführen des MATLAB-Skripts erzeugt dieses Fenster.

![Screenshot einer einfachen Anwendung nach klicken des Buttons.](/docResources/SampleApplication_I.png)

Auf den ersten Blick sieht dieser Prototyp fast aus, wie das angestrebte Produkt. Einzig die Farbe des Buttons stimmt nicht. Klickt man auf den Button passiert nichts. Diese Funktionalität gilt es im nächsten Abschnitt zu ergänzen.

#### Implementierung der Logik
Die Logik unserer Anwendung beschränkt sich auf eine Scene. Nach einem Klick auf den Button soll soll sich das Label derselben Scene verändern. Um diese Logik zu implementieren muss zunächst das fxml angepasst werden.
```xml
<?xml version="1.0" encoding="UTF-8"?>

<?import javafx.scene.control.Button?>
<?import javafx.scene.control.Label?>
<?import javafx.scene.layout.VBox?>

<VBox xmlns="http://javafx.com/javafx/8.0.65" xmlns:fx="http://javafx.com/fxml/1" fx:controller="generic_jfx_application.event_transfer.Controller">
  <children>
      <Label fx:id="lbl" alignment="TOP_LEFT" maxHeight="1.7976931348623157E308" maxWidth="1.7976931348623157E308" text="Hello world!!!" VBox.vgrow="ALWAYS" />
      <Button fx:id="btn" maxWidth="1.7976931348623157E308" mnemonicParsing="false" onAction="#handleEvent" text="click me" />
   </children>
</VBox>
```
Hier muss auf dem root-element der Bedienelemente das fx:controller-Attribut gesetzt werden. Um events von der JavaFX-GUI zum jfx4matlab-Package zu übertragen muss hier die Controller-Klasse aus dem generic_jfx_application.event_transfer-Package ergänzt werden. Dannach kann das onAction-Event des Buttons durch registrieren des #handleEvent-Callbacks überwacht werden. Um das Label und den Button auf Seiten von MATLAB referenzieren zu können müssen zu guter Letzt nur noch fx:ids an beide GUI-Elemente vergeben werden. Dannach kann man damit beginnen die Logik in MATLAB zu implementieren. Dazu wird die JFXSceneController-Klasse erweitert.
```MATLAB
classdef SampleController < jfx4matlab.matlab.JFXSceneController
    %SAMPLECONTROLLER Controller class for the sample scene.

    properties
        lbl; % The label with the name lbl.
        list; % The listView with the name list.
    end

    methods
        function obj = SampleController(fxml)
            obj = obj@jfx4matlab.matlab.JFXSceneController(fxml);
        end

        function initScene(obj)
            obj.lbl = obj.getUiElement('lbl');
            obj.list = obj.getUiElement('list');
        end

        function eventConsumed = handleSceneEvent(obj, e)
            eventConsumed = 0;
            if(strcmp(e.fxId, 'btn')...
                    && strcmp(e.action, 'ACTION'))
                % Handle click on btn.
                obj.applyTask(obj.lbl, 'setText', 'heureka');
                eventConsumed = true;
            end
        end
    end
end
```   
Beim Überschreiben der initScene-Methode können wir an Referenzen auf die Bedienelemente kommen. Durch Überschreiben der handleSceneEvent-Methode erlangen wir Zugriff auf die Events. Wann immer ein Event in JavaFX ausgelöst wird, wird diese handleSceneEvent-Methode aufgerufen. Sie bekommt als Eingangs-Parameter ein Event-Objekt, welches sowohl den Namen des Quell-Bedienelements, als auch den Namen des Events enthält. Über beliebige Bedingungen kann auf diese Events reagiert werden. Wurde das Event verarbeitet, so soll handleSceneEvent true zurückgeben, ansonsten false. Wird ein Event nicht verarbeitet, so wird eine Warnung auf der Kommandozeile ausgegeben. In der Beispielanwendung wird auf das ACTION-Event, vom Quell-GUI-Element "btn", mit dem Ändern des Textes reagiert.

Wird das MATLAB-Skript nun ausgeführt, so öffnet sich unser Prototyp in gewohnter Manier. Auf einen Klick auf den Button, wird mit dem Verändern des Textes reagiert.   

![Screenshot einer einfachen Anwendung nach klicken des Buttons.](/docResources/SampleApplication_II.png)

#### Anwenden eines Stylesheets
Der letzte Schritt bei der Implementierung dieser einfachen Beispielanwendung ist das Ändern der Button-Farbe. Das lässt sich über folgendes Cascading Style Sheet bewerkstelligen.
```css
.button {
	-fx-background-color: #ed8b00;
  -fx-text-fill: #63666a;
}
```
Es ändert die Hintergrundfarbe eines Buttons zu orange und die Textfarbe zu grau. Damit das css beim generieren der Scene berücksichtigt wird muss es im fxml verknüpft werden.
```xml
<?xml version="1.0" encoding="UTF-8"?>

<?import java.net.URL?>
<?import javafx.scene.control.Button?>
<?import javafx.scene.control.Label?>
<?import javafx.scene.layout.VBox?>

<VBox xmlns="http://javafx.com/javafx/8.0.65" xmlns:fx="http://javafx.com/fxml/1" fx:controller="generic_jfx_application.event_transfer.Controller">
   <stylesheets>
      <URL value="<PATH_TO_THE_CSS_FILE>" />
   </stylesheets>
   <children>
      <Label fx:id="lbl" alignment="TOP_LEFT" maxHeight="1.7976931348623157E308" maxWidth="1.7976931348623157E308" text="Hello world!!!" VBox.vgrow="ALWAYS" />
      <Button fx:id="btn" maxWidth="1.7976931348623157E308" mnemonicParsing="false" onAction="#handleEvent" text="click me" />
   </children>
</VBox>
```
Dazu muss die stylesheets-Eigenschaft des root-Elements der Bedienelemente angepasst werden. Hier muss Pfad zum css vermerkt werden. Damit das URL-Tag genutzt werden kann muss zusätlich URL aus dem java.net-Package importiert werden.

Nun ist die Beispielanwendung fertig. Sowohl das Aussehen, als auch die Logik sollten jetzt entsprechend der Beschreibung unserer Hello World Anwendung funktionieren.
