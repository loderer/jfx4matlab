# Anwenden eines Stylesheets
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

Nun ist die Beispielanwendung fertig. Sowohl das Aussehen, als auch die Logik sollten jetzt der Beschreibung, unserer Hello World Anwendung, entsprechen.
