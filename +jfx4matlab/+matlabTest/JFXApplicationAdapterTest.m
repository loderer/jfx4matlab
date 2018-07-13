classdef JFXApplicationAdapterTest < matlab.unittest.TestCase
    properties
        jfxAppAdapter; 
    end
 
    methods(TestMethodSetup)
        function startUp(testCase)
            testCase.jfxAppAdapter = jfx4matlab.matlab.JFXApplicationAdapter();
        end
    end
 
    methods(TestMethodTeardown)
        function close(testCase)
            allStageControllers =...
                testCase.jfxAppAdapter.getAllStageControllers();
            for i = 1 : size(allStageControllers, 1);
                sceneController = allStageControllers{i, 1}...
                    .getSceneController(); 
                if(sceneController ~= -1) 
                    sceneController.forceClose();
                end
            end
        end
    end
 
    methods(Test)
        function initTest(testCase) 
            assertEqual(testCase, ...
                exist('jfx_4_matlab_java.JFXApplication'), 8); 
            
            assertEqual(testCase, ...
                exist('javafx.application.Application'), 8);
        end
        
        function addStageControllerTest1(testCase) 
            stageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxAppAdapter,'firstStageController');
            
            testCase.jfxAppAdapter.addStageController(stageController); 
            
            assertEqual(testCase, ...
                size(testCase.jfxAppAdapter.getAllStageControllers(), 1), 1); 
        end
        
        function addStageControllerTest2(testCase) 
            firstStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxAppAdapter,'stageController');
            secondStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxAppAdapter,'stageController');
            
            testCase.jfxAppAdapter.addStageController(firstStageController);
            testCase.jfxAppAdapter.addStageController(secondStageController);
            
            assertEqual(testCase, ...
                size(testCase.jfxAppAdapter. ...
                getStageControllerByTitle('stageController'), 1), 2); 
        end
        
        function removeStageControllerTest1(testCase)
            firstStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxAppAdapter,'stageController');
            secondStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxAppAdapter,'stageController');
            testCase.jfxAppAdapter.addStageController(firstStageController);
            testCase.jfxAppAdapter.addStageController(secondStageController);
            
            testCase.jfxAppAdapter.removeStageController(firstStageController);
            
            assertEqual(testCase, ...
                size(testCase.jfxAppAdapter. ...
                getStageControllerByTitle('stageController'), 1), 1); 
        end
        
        function removeStageControllerTest2(testCase)
            firstStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxAppAdapter,'stageController');
            testCase.jfxAppAdapter.addStageController(firstStageController);
            
            testCase.jfxAppAdapter.removeStageController(firstStageController);
            
            assertEqual(testCase, ...
                size(testCase.jfxAppAdapter. ...
                getStageControllerByTitle('stageController'), 1), 0);
        end
    end
end

