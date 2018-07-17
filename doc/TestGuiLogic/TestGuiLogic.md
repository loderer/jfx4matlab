# Testen der GUI-Logik
Ein Alleinstellungsmerkmal des jfx4matlab-Packages is die Möglichkeit die Logik der GUI zu testen. So kann sichergestellt werden, dass die GUI korrekt initialisiert und Events korrekt verarbeitet werden.

Das Thema "Testen der GUI-Logik" wird im Folgenden auf Basis der [Hello World Anwendung](../../samples/HelloWorld) erklärt. Wir möchten prüfen, ob die Anwendung korrekt initialisiert und das Event (Klick auf den Button) korrekt verarbeitet wird. Dazu implementieren wir folgenden Testfall:
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
Vor allen Tests initialisiert dieser Testfall den Klassenpfad und ermittelt den Pfad zur fxml-Datei der Hello World Anwendung. Vor jedem Test initialisiert er die Applikation neu. Nach jedem Test werden die im Test geöffneten Fenster geschlossen.

Im ersten Test (doNotClickBtn) wird überprüft, ob die Scene korrekt initialisiert wurde.

Im zweiten Test (clickBtn) wird geprüft, ob das Event (Klick auf den Button) korrekt verarbeitet wrid. Dazu wird das Event gemockt und daraufhin der IST-Zustand der Benutzeroberfläche mit dem SOLL-Zustand abgeglichen.

Gestartet wird der Testfall durch instanziieren und ausführen der SampleTestCase-Klasse.

Der Sourcecode dieses Beispiels befindet sich in [diesem Ordner](../../samples/TestGuiLogic). Zum Ausführen des Beispiels muss das gesamte Repository ausgecheckt werden! Die Ordnerstruktur darf nicht verändert werden!
