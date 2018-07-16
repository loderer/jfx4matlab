classdef JFXApplicationTest < matlab.unittest.TestCase
    properties
        jfxApplication; 
    end
 
    methods(TestMethodSetup)
        function startUp(testCase)
            testCase.jfxApplication = jfx4matlab.matlab.JFXApplication();
        end
    end
 
    methods(TestMethodTeardown)
        function close(testCase)
            allStageControllers =...
                testCase.jfxApplication.getAllStageControllers();
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
                exist('generic_jfx_application.GenericJfxApplication'), 8); 
            
            assertEqual(testCase, ...
                exist('javafx.application.Application'), 8);
        end
        
        function addStageControllerTest1(testCase) 
            stageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxApplication,'firstStageController');
            
            testCase.jfxApplication.addStageController(stageController); 
            
            assertEqual(testCase, ...
                size(testCase.jfxApplication.getAllStageControllers(), 1), 1); 
        end
        
        function addStageControllerTest2(testCase) 
            firstStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxApplication,'stageController');
            secondStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxApplication,'stageController');
            
            testCase.jfxApplication.addStageController(firstStageController);
            testCase.jfxApplication.addStageController(secondStageController);
            
            assertEqual(testCase, ...
                size(testCase.jfxApplication. ...
                getStageControllerByTitle('stageController'), 1), 2); 
        end
        
        function removeStageControllerTest1(testCase)
            firstStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxApplication,'stageController');
            secondStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxApplication,'stageController');
            testCase.jfxApplication.addStageController(firstStageController);
            testCase.jfxApplication.addStageController(secondStageController);
            
            testCase.jfxApplication.removeStageController(firstStageController);
            
            assertEqual(testCase, ...
                size(testCase.jfxApplication. ...
                getStageControllerByTitle('stageController'), 1), 1); 
        end
        
        function removeStageControllerTest2(testCase)
            firstStageController = jfx4matlab.matlab. ...
                JFXStageController(testCase.jfxApplication,'stageController');
            testCase.jfxApplication.addStageController(firstStageController);
            
            testCase.jfxApplication.removeStageController(firstStageController);
            
            assertEqual(testCase, ...
                size(testCase.jfxApplication. ...
                getStageControllerByTitle('stageController'), 1), 0);
        end
    end
end

