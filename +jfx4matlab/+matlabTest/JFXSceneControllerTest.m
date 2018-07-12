classdef JFXSceneControllerTest < matlab.unittest.TestCase
    properties
        jfxAppAdapter; 
    end
 
    methods(TestMethodSetup)
        function setUp(testCase)
             testCase.jfxAppAdapter = jfx4matlab.matlab.JFXApplicationAdapter();
        end
    end
 
    methods(TestMethodTeardown)
        function close(testCase)
            allStageControllers =...
                testCase.jfxAppAdapter.getAllStageControllers();
            for i = 1 : allStageControllers.size();
                sceneController = allStageControllers.get(i)...
                    .getSceneController(); 
                if(sceneController ~= -1) 
                    sceneController.forceClose();
                end
            end
        end
    end
 
    methods(Test)
        function ctorTest(testCase) 
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            
            sceneController = jfx4matlab.matlab. ...
                JFXSceneController(fxmlFilePath); 
            
            assertEqual(testCase, sceneController.getPathToFxml(),...
                fxmlFilePath);
            assertEqual(testCase, sceneController.getStageController(), []);
            assertFalse(testCase, sceneController.isInitialized());
            assertEqual(testCase,...
                sceneController.getJfxApplicationAdapter(),...
                []);
        end
        
        function initTest(testCase)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            stageController = jfx4matlab.matlab.JFXStageController(...
                testCase.jfxAppAdapter, 'stageController');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            
            stageController.showScene(sceneController); 
            
            assertTrue(testCase, sceneController.isInitialized()); 
            assertEqual(testCase,...
                sceneController.getStageController(),...
                stageController);
            assertEqual(testCase,...
                sceneController.getJfxApplicationAdapter(),...
                testCase.jfxAppAdapter);
        end
        
        function mockSceneEventTest(~)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            
            sceneController.mockSceneEvent('fxId', 'action'); 
        end
        
        function pushBackTaskTest1(testCase)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            stageController = jfx4matlab.matlab.JFXStageController(...
                testCase.jfxAppAdapter, 'stageController');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            stageController.showScene(sceneController);
            
            lbl = sceneController.getUiElement('lbl');
            sceneController.pushBackTask(lbl, 'setText', 'lbl'); 
            btn = sceneController.getUiElement('btn');
            sceneController.pushBackTask(btn, 'setText', 'btn'); 
            sceneController.applyTasks(); 
            lblText = sceneController.applyTask(lbl, 'getText'); 
            btnText = sceneController.applyTask(btn, 'getText'); 
            
            assertEqual(testCase, lblText, 'lbl'); 
            assertEqual(testCase, btnText, 'btn'); 
        end
        
        function pushBackTaskTest2(testCase)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            stageController = jfx4matlab.matlab.JFXStageController(...
                testCase.jfxAppAdapter, 'stageController');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            stageController.showScene(sceneController);
            
            lbl = sceneController.getUiElement('lbl');
            sceneController.applyTask(lbl, 'setText', 'lbl'); 
            btn = sceneController.getUiElement('btn');
            sceneController.applyTask(btn, 'setText', 'btn'); 
            lblText = sceneController.applyTask(lbl, 'getText'); 
            btnText = sceneController.applyTask(btn, 'getText'); 
            
            assertEqual(testCase, lblText, 'lbl'); 
            assertEqual(testCase, btnText, 'btn'); 
        end
        
        function pushBackTaskTest3(testCase)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            stageController = jfx4matlab.matlab.JFXStageController(...
                testCase.jfxAppAdapter, 'stageController');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            stageController.showScene(sceneController);
            
            lbl = sceneController.getUiElement('lbl');
            
            testCase.verifyError(...
                @()sceneController.applyTask(lbl),...
                'EXCEPTION:IllegalArgument');
        end
        
        function pushBackTaskTest4(testCase)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            stageController = jfx4matlab.matlab.JFXStageController(...
                testCase.jfxAppAdapter, 'stageController');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            stageController.showScene(sceneController);
            
            lbl = sceneController.getUiElement('lbl');
            
            testCase.verifyError(...
                @()sceneController.pushBackTask(lbl),...
                'EXCEPTION:IllegalArgument');
        end
        
        function forceCloseTest(testCase)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            stageController = jfx4matlab.matlab.JFXStageController(...
                testCase.jfxAppAdapter, 'stageController');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            stageController.showScene(sceneController);
            
            sceneController.forceClose(); 
            
            assertEqual(testCase, ...
                testCase.jfxAppAdapter.getStageControllerByTitle('stageController').size(),...
                0); 
        end
        
        function isCloseableTest(testCase)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            
            assertTrue(testCase, sceneController.isCloseable()); 
        end
        
        function handleStageEventBaseTest1(~)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            
            fxId = java.lang.String('fxid');
            action = java.lang.String('action');
            sceneController.handleStageEventBase(...
                struct('fxId', fxId, 'action', action));         
        end
        
        function handleStageEventBaseTest2(testCase)
            [fxmlFilePath, ~, ~] = fileparts(mfilename('fullpath'));
            fxmlFilePath = fullfile(fxmlFilePath, '+resources',...
                'sample.fxml');
            stageController = jfx4matlab.matlab.JFXStageController(...
                testCase.jfxAppAdapter, 'stageController');
            sceneController = jfx4matlab.matlab.JFXSceneController(...
                fxmlFilePath);
            stageController.showScene(sceneController);
            
            fxId = java.lang.String('root');
            action = java.lang.String('CLOSE');
            sceneController.handleStageEventBase(...
                struct('fxId', fxId, 'action', action));
            
            assertEqual(testCase, ...
                testCase.jfxAppAdapter.getStageControllerByTitle('stageController').size(),...
                0);
        end
    end
end