% Add required directories to classpath.-----------------------------------
import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin

% Add MATLAB-library to class path. 
addpath('C:\Users\rudi\Documents\GitHub\BaMatlab');
import jfx4matlab.*;
%--------------------------------------------------------------------------

suite = TestSuite.fromPackage('jfx4matlab.matlabTest.collections.list');
runner = TestRunner.withTextOutput;
runner.addPlugin(CodeCoveragePlugin.forFolder('C:\Users\rudi\Documents\GitHub\BaMatlab\+jfx4matlab\+matlab\+collections\+list\'))
result = runner.run(suite);