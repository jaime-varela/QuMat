classdef tXgate < matlab.unittest.TestCase
    %TINITIALIZATION X gate
        
    methods (Test)
        function tCreateHadamardState1(testCase)
            qc = qregister(4);
            qc = xGate(qc,0);
            qc = xGate(qc,2);
            qc = xGate(qc,3);

            newState = qc.getState();
            expectedState = zeros(16,1);
            expectedState(11+1) = 1;
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        
        function tGateArrayHadamard2(testCase)
           qc = qregister(4);
           xGate = standardGates.X;
           gateArray = xGate;
           gateArray(:,:,2) = eye(2);
           gateArray(:,:,3) = standardGates.Flip;
           gateArray(:,:,4) = standardGates.X;
           qc = singleQubitGateArray(qc,gateArray);
           newState = qc.getState();
           expectedState = zeros(16,1);
           expectedState(11+1) = 1;
           import matlab.unittest.constraints.IsEqualTo
           testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        
    end
    
    methods (Access = private)
        % to do move this to a test util
        function tolObj = getTolObj(testCase)
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            tolObj = AbsoluteTolerance(1.0e-10) & RelativeTolerance(1.0e-10);
        end
    end
end

