classdef geometryTest < matlab.unittest.TestCase
    % GEOMETRYTEST
    % Test class for testing if program can handle different kinds of input
    % meshes
    
    properties (TestParameter)
        meshes = struct(...
            'smallCube1', [1 1 -1;1 -1 -1;1 1 1;1 -1 1;-1 1 -1;-1 -1 -1;-1 1 1;-1 -1 1], ...
            'smallCube2', [0 0 0;0 0 1;0 1 0;0 1 1;1 0 0;1 0 1;1 1 0;1 1 1], ...
            'randomCube1', randi(10, 8, 3),...
            'randomCube2', randi(10, 8, 3),...
            'randomCube3', randi(10, 8, 3),...
            'randomCube4', randi(10, 8, 3)...
            );
        duplicate_meshes = struct(...
            'cubeWithDuplicates', [1 1 -1;1 -1 -1;1 1 1;1 -1 1;-1 1 -1;-1 -1 -1;1 1 1;-1 -1 1]);

        files = struct(...
            'obj', strcat(pwd,'\meshes\example_mesh_3D.obj'), ...
            'txt', strcat(pwd,'\meshes\cube_nodes.txt'));
        files_result = struct(...
            'obj', [1 1 -1;1 -1 -1;1 1 1;1 -1 1;-1 1 -1;-1 -1 -1;-1 1 1;-1 -1 1], ...
            'txt', [0 0 0;0 0 1;0 1 0;0 1 1;1 0 0;1 0 1;1 1 0;1 1 1]);
        files_gibberish = struct(...
            'gibberish', 'huehue', ...
            'gibberish2', 'blaoeuchaoeurcoha', ...
            'gibberishDots', 'oeuouou.hue', ...
            'gibberishMultipleDots', 'orocehuo.hue.hue.hue.hue', ...
            'gibberishSlashes', 'aoeuoeuo\oeuoeu/ooeuo', ...
            'gibberishDotsSlashes', 'oecuhaoeu/oeuoceuh/oeuch.hue');
    end
    
    methods (TestMethodSetup)
        function MethodSetup(testCase)
            orig = rng;
            testCase.addTeardown(@rng, orig)
            rng(42) % Answer to the Ultimate Question of Life, the Universe, and Everything.
        end
    end
    
    methods (Test)
        % this test gives duplicate rows on purpose to the readMesh
        % function
        function testDuplicates(testCase, duplicate_meshes)
            testCase.verifyWarning(@() readMesh(duplicate_meshes), ...
                'MATLAB:delaunayTriangulation:DupPtsWarnId', ...
                'Delaunay triangulation should raise an warning when introducing duplicate values!');
        end
        function testFalseFilenames(testCase, files_gibberish)
            testCase.verifyError(@() readMesh(files_gibberish), ...
                'MATLAB:FileIO:InvalidFid', ...
                "Invalid filenames should raise an error!");
        end
        function testMeshes(testCase, meshes)
            actSolution = readMesh(meshes);
            testCase.verifyEqual(actSolution.Points, meshes, ... 
                "Input of matrix/array failed!");
        end
    end
    
    methods (Test, ParameterCombination='sequential')
        function testLegitFilenames(testCase, files, files_result)
            actSolution = readMesh(files);
            testCase.verifyEqual(actSolution.Points, files_result, ... 
                "Input of example file failed!");
        end
    end
end