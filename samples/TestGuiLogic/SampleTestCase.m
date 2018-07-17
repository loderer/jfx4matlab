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
            jfx4matlabPath = fullfile(pathToThisDir, '..', '..');
            addpath(jfx4matlabPath);
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