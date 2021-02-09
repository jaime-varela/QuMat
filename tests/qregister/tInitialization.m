classdef tInitialization < matlab.unittest.TestCase
    %TINITIALIZATION Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Test)
        function tThreeQubitZeroState(testCase)
            qc = qregister(3);
            testCase.verifyTrue(qc.isSparse);
            state = qc.getState(); % gets full Q-state
            dims = size(state);
            testCase.verifyTrue(qc.hilbertSpaceDimension == 8);
            testCase.verifyTrue(dims(1) == 8);
            testCase.verifyTrue(state(1) == 1);
            testCase.verifyTrue(nnz(state) == 1);
        end

        function tComplexColArray(testCase)
            hadamardState = (1.0/sqrt(8)).*ones(8,1);
            qc = qregister(hadamardState);
            testCase.verifyFalse(qc.isSparse);
            state = qc.getState(); % gets full Q-state
            dims = size(state);
            testCase.verifyTrue(qc.hilbertSpaceDimension == 8);
            testCase.verifyTrue(dims(1) == 8);
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            tolObj = AbsoluteTolerance(1.0e-10) & RelativeTolerance(1.0e-10);            
            testCase.verifyThat(state,IsEqualTo(hadamardState,'Within',tolObj()));                

        end
        
        function tComplexRowArray(testCase)
            hadamardState = (1.0/sqrt(8)).*ones(1,8);
            qc = qregister(hadamardState);
            testCase.verifyFalse(qc.isSparse);
            state = qc.getState(); % gets full Q-state
            dims = size(state);
            testCase.verifyTrue(qc.hilbertSpaceDimension == 8);
            testCase.verifyTrue(dims(1) == 8);
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            tolObj = AbsoluteTolerance(1.0e-10) & RelativeTolerance(1.0e-10);            
            testCase.verifyThat(state,IsEqualTo(transpose(hadamardState),'Within',tolObj()));                

        end

        
        function tLexicographState(testCase)
            % 3 qubits in |2>
            qc = qregister(3,2);
            testCase.verifyTrue(qc.isSparse);
            state = qc.getState(); % gets full Q-state
            dims = size(state);
            testCase.verifyTrue(qc.hilbertSpaceDimension == 8);
            testCase.verifyTrue(dims(1) == 8);
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            expectedState = [0; 0; 1; 0; 0 ; 0; 0; 0];
            tolObj = AbsoluteTolerance(1.0e-10) & RelativeTolerance(1.0e-10);            
            testCase.verifyThat(state,IsEqualTo(expectedState,'Within',tolObj()));                

        end
        
        function tQubitInput(testCase)
            % 3 qubits in |2>
            qc = qregister(0,1,0);
            testCase.verifyTrue(qc.isSparse);
            state = qc.getState(); % gets full Q-state
            dims = size(state);
            testCase.verifyTrue(qc.hilbertSpaceDimension == 8);
            testCase.verifyTrue(dims(1) == 8);
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            expectedState = [0; 0; 1; 0; 0 ; 0; 0; 0];
            tolObj = AbsoluteTolerance(1.0e-10) & RelativeTolerance(1.0e-10);            
            testCase.verifyThat(state,IsEqualTo(expectedState,'Within',tolObj()));                

        end

        
    end
end

