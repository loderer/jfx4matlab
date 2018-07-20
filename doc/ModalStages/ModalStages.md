# Create modal stages
By default, each window is non-modal. If an application consists of several non-modal windows, you can bring each of them into the foreground. If you want to force a user to do something, you can achieve this, by changeing the modality of a window. This enables fixing a window in front of another window or even in front of all windows of an application. Each windows modality-attribute must have one of these three values:
- NONE
- APPLICATION_MODAL
- WINDOW_MODAL  

Their use is described below.

## NONE
As already mentioned, each window is non-modal by default. Non-modal windows do not have any effect on the visibility of other windows.

You can create a non-modal window by creating a stage like this:
```
JFXStageController(<JFXApplication>, <TITLE>);
```

## APPLICATION_MODAL
An application-modal window blocks the users access to each other window of the application until the application-modal window is closed.

You can create an application-modal window by creating a stage like this:
```
JFXStageController(<JFXApplication>, <TITLE>, javafx.stage.Modality.APPLICATION_MODAL);
```
## WINDOW_MODAL
An window-modal window blocks the users access to each owner-window recursively until the window-modal window is closed.

You can create an window-modal window by creating a stage like this:
```
JFXStageController(<JFXApplication>, <TITLE>, javafx.stage.Modality.WINDOW_MODAL, <OWNER_JFXSTAGECONTROLLER>);
```
The OWNER_STAGECONTROLLER is the JFXStageController of the window to be hidden, when the new window is shown.
