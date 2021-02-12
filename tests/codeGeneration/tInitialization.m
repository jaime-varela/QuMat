classdef tInitialization < matlab.unittest.TestCase
    % codegen test for hadamard state creation
    
    methods (Test)
        function tQubitInit(testCase)
            import matlab.unittest.fixtures.TemporaryFolderFixture
            
            tempFixture = testCase.applyFixture(TemporaryFolderFixture);
            cd(tempFixture.Folder);
            % create a 4 qubit hadamard state
            codegen initialize_t -args {4}
        end
        
    end
end

