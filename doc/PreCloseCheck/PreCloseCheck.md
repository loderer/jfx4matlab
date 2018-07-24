# Pre close checks
Do you like to check some conditions or trigger a task before closing a window?

You can achieve this by redefining the "isCloseable"-function of the JFXSceneController-class. This function is called just before the window is closed. It allows to call any function in its body. If "isCloseable" returns true, the window is closed. If it returns false, the window stays open.
