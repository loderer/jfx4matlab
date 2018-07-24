# General information
# Stage and scene
Each window is separated into two parts. The content of the window is named scene. The frame around the content is called stage. The stage consists of an icon, the title and buttons to minimize, maximize and close the window.

![The difference beween a stage and a scene.](SceneAndStage.png)

## Define scenes
The content of a scene is defined by its fxml-file. You can create a fxml-file, following [this instruction](https://docs.oracle.com/javafx/2/get_started/fxml_tutorial.htm), by hand. If you want to create the gui intuitively, we recommend using the [SceneBuilder-tool](https://gluonhq.com/products/scene-builder/). It allows creating the fxml by drag-and-drop.

## Access gui-elements
You can resolve the reference to any gui-element of a scene by calling the "getUiElement"-function of the corresponding JFXSceneController. To resolve a gui-element you have to specify an identifier in the fxml-file.

## Change gui-elements
Each object, resolved by the "getUiElement"-function, should only be modified using the javaFX application thread. To delegate tasks to the javaFX
application thread, you can use the

- "pushBackTask",
- "applyTasks" and
- "applyTask"

functions of the JFXSceneController-class.

## Event naming
In the fxml-file, each events name has the prefix "on". This prefix is indicating, that the registered callback is called, when the event is triggered. If you want to handle an event within the "handleSceneEvent"- or "handleStageEvent"-functions, the events name does not contain this prefix anymore!  

## Initialize scenes
Basically the initialization of a scene and the resolution of gui-elements should take place in the "initScene"-function of the JFXSceneController. This ensures that both actions happen at the right time.

## Close windows

By default windows can be closed by clicking on the cross in the upper right corner. To close windows programmatically, you can call the functions

- "close" and
- "forceClose"

of the JFXSceneController-class.

<b>Watch out!</b> -If you call "forceClose", the [pre close conditions](../PreCloseCheck/PreCloseCheck.md) are <b>not</b> evaluated.
