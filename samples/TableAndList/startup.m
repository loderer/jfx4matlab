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
pathToFxml = fullfile(pathToThisDir, 'sample.fxml');

% Create javaFX-application.
jfxApplication = JFXApplication();

% Create stage. 
stageController = JFXStageController(jfxApplication, 'TableAndList');
% Create scene
sceneController = SampleController(pathToFxml);
stageController.showScene(sceneController);