classdef tCreateHadamardState < matlab.unittest.TestCase
    % codegen test for hadamard state creation
    
    methods (Test)
        function tCodegenHadamardCreation(testCase)
            import matlab.unittest.fixtures.TemporaryFolderFixture
            
            tempFixture = testCase.applyFixture(TemporaryFolderFixture);
            cd(tempFixture.Folder);
            % create a 4 qubit hadamard state
            codegen createHadamardState_t -args {4}
        end
        function tCodegenHadamardArrayCreation(testCase)
            import matlab.unittest.fixtures.TemporaryFolderFixture
            
            tempFixture = testCase.applyFixture(TemporaryFolderFixture);
            cd(tempFixture.Folder);
            % create a 4 qubit hadamard state
            codegen createHadamardGateArray_t -args {4}
        end
        
    end
end

