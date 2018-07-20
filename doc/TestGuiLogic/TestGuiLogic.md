# Test the logic of the gui
One unique function of the jfx4matlab-package is the possibility of testing the logic of the gui. This ensures that the gui initializes correctly and events were processed as requested.

To explain the the testing-functions clear, we describe them while writing some tests for the [Hello World application](../../samples/HelloWorld). Therefore we use MATLAB-internal "matlab.unittest.TestCase" base-class.

```matlab
classdef SampleTestCase < matlab.unittest.TestCase

    properties
        jfxApplication;
        sampleController;
        pathToFxml;
    end

    methods(TestClassSetup)
        function setUpTestCase(testCase)
            % Add required directories to classpath.-----------------------------------
            % Get the path to the folder containing this file.
            [pathToThisDir, ~, ~] = fileparts(mfilename('fullpath'));
            % Add all MATLAB-sources to the class path.
            addpath(genpath(pathToThisDir));
            % Add MATLAB-library to class path.
            addpath(<PATH_TO_THE_JFX4MATLAB_PACKAGE>);
            import jfx4matlab.matlab.*;
            %--------------------------------------------------------------------------

            % Get the path to the fxml.
            testCase.pathToFxml = fullfile(pathToThisDir, 'sample.fxml');
        end
    end

    methods(TestMethodSetup)
        function start(testCase)
            import jfx4matlab.matlab.*;
            testCase.jfxApplication = JFXApplication();
            stageController = JFXStageController(...
                testCase.jfxApplication, 'Hello World');
            testCase.sampleController =...
                SampleController(testCase.pathToFxml);
            stageController.showScene(testCase.sampleController);
        end
    end

    methods(TestMethodTeardown)
        function close(testCase)
            allStageControllers =...
                testCase.jfxApplication.getAllStageControllers();
            for i = 1 : size(allStageControllers)
                allStageControllers{i}...
                    .getSceneController().forceClose();
            end
        end
    end

    methods(Test)
        function doNotClickBtn(testCase)
            lbl_value = char(testCase.sampleController.lbl.getText());
            testCase.verifyEqual(lbl_value, 'Hello world!!!', ...
                'The scene is initialized incorrectly.')
        end

        function clickBtn(testCase)
            testCase.sampleController.mockSceneEvent('btn', 'ACTION');
            lbl_value = char(testCase.sampleController.lbl.getText());
            testCase.verifyEqual(lbl_value, 'heureka', ...
                'Click on button has been handled incorrect.')
        end
    end
end
```
Before running a test the above testcase initializes the classpath and determines the path of the fxml-file. Before each test the application is reinitialized. After each test all windows, opened by the test, are closed.

The first test ("doNotClickBtn") checks if the scene is initialized correctly.

The second test ("clickBtn") checks if the event (click the button) is processed correctly. Therefore the event is mocked. After that the actual state of the application is compared with the target state of the application.

(Similar to mocking a event on scene-level, you can mock events on stage-level. Therefore you have to call the "mockStageEvent"-function of the appropriate JFXStageController. If you write
```Matlab
<JFXStageController>.mockStageEvent('root', 'CLOSE');
```
you simulate a click on the close-button of the window.)

You can run the testcase by instantiating and running it.  

The sources of this example are available [here](../../samples/TestGuiLogic). To run the example you have to check out the whole repository! The structure of the folders must not be changed!
