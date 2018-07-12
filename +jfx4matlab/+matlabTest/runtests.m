% Add required directories to classpath.-----------------------------------
import matlab.unittest.TestSuite
import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin

% Add MATLAB-library to class path. 
addpath('C:\Users\rudi\Documents\GitHub\BaMatlab');
import jfx4matlab.*;
%--------------------------------------------------------------------------

listTestSuite = TestSuite.fromPackage('jfx4matlab.matlabTest.collections.list');
mapTestSuite = TestSuite.fromPackage('jfx4matlab.matlabTest.collections.map');
defaultTestSuite = TestSuite.fromPackage('jfx4matlab.matlabTest');

allSuites = [...
    listTestSuite,...
    mapTestSuite,...
    defaultTestSuite...
    ];
runner = TestRunner.withTextOutput;
runner.addPlugin(CodeCoveragePlugin.forPackage('jfx4matlab.matlab.collections.list'))
runner.addPlugin(CodeCoveragePlugin.forPackage('jfx4matlab.matlab.collections.map'))
runner.addPlugin(CodeCoveragePlugin.forPackage('jfx4matlab.matlab'))
result = runner.run(allSuites);