% Add required directories to classpath.-----------------------------------

% Get the path to the folder containing this file.
[pathToHelloWorldDir, ~, ~] = fileparts(mfilename('fullpath'));
% Add all MATLAB-sources to the class path. 
addpath(genpath(pathToHelloWorldDir));
% Add MATLAB-library to class path. 
jfx4matlabPath = fullfile(pathToHelloWorldDir, '..', '..');
addpath(jfx4matlabPath);
import jfx4matlab.matlab.*;
%--------------------------------------------------------------------------

% Get the path to the fxml.
pathToFxml = fullfile(pathToHelloWorldDir, 'sample.fxml');

% Create javaFX-application.
jfxApplication = JFXApplication();

% Create stage. 
stageController = JFXStageController(jfxApplication, 'Hello World');
% Create scene
sceneController = SampleController(pathToFxml);
stageController.showScene(sceneController);