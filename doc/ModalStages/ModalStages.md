# Erzeugen modaler Fenster
Per default ist jede Stage (jedes Fenster) nicht-Modal. Das bedeutet alle Fenster einer Applikation können gleichermaßen bedient und in den Vordergrund geholt werden. Will man den Nutzer zu einer Eingabe zwingen, so ist es notwendig ein Fenster im Vordergrund zu fixieren. Zu diesem Zweck kann die Modalitäts-Eigenschaft jedes Fensters einen der drei Werte
- NONE,
- APPLICATION_MODAL oder
- WINDOW_MODAL

annehmen. Ihre Verwendung wird im Folgenden näher erläutert.

## NONE
Wie bereits in der Einführung beschrieben ist jede Stage standardmäßig NONE-Modal. Nicht-Modale Fenster haben keine Auswirkung auf die Sichtbarkeit aller anderen Fenster der Applikation.

Eine Nicht-Modale Stage kann durch folgenden Aufruf, des Konstruktors, der JFXSTageController-Klasse, erzeugt werden.
```
JFXStageController(<JFXApplication>, <TITLE>);
```

## APPLICATION_MODAL
Wird eine Stage mit dem Attribut APPLICATION_MODAL versehen, so verdeckt es alle anderen Fenster der Applikation. Solange die Stage sichtbar ist kann der Benutzer kein anderes Fenster der Anwendung in den Vordergrund holen.

Eine Application-Modale Stage kann durch folgenden Aufruf, des Konstruktors, der JFXSTageController-Klasse, erzeugt werden.
```
JFXStageController(<JFXApplication>, <TITLE>, javafx.stage.Modality.APPLICATION_MODAL);
```
## WINDOW_MODAL
Einem jeden Window-Modalen Fenster ist sein Besitzer-Fenster bekannt. Solange es sichtbar ist, verdeckt es sein Besitzer-Fenster und rekursiv dessen Besitzer-Fenster.

Eine Window-Modale Stage kann durch folgenden Aufruf, des Konstruktors, der JFXSTageController-Klasse, erzeugt werden. OWNER_JFXSTAGECONTROLLER ist dabei der JFXStageController des Besitzer-Fensters.
```
JFXStageController(<JFXApplication>, <TITLE>, javafx.stage.Modality.WINDOW_MODAL, <OWNER_JFXSTAGECONTROLLER>);
```
