classdef tHadamard < matlab.unittest.TestCase
    %TINITIALIZATION Summary of this class goes here
    %   Detailed explanation goes here
        
    methods (Test)
        function tCreateHadamardState1(testCase)
            qc = qregister(3);
            qc = hGate(qc,0);
            qc = hGate(qc,1);
            qc = hGate(qc,2);

            newState = qc.getState();
            expectedState = ones(qc.hilbertSpaceDimension,1).*(1/sqrt(1.0*qc.hilbertSpaceDimension));
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        
        function tGateArrayHadamard2(testCase)
           qc = qregister(3);
           hgate = standardGates.H;
           gateArray = hgate;
           gateArray(:,:,2) = hgate;
           gateArray(:,:,3) = hgate;
           qc = singleQubitGateArray(qc,gateArray);
           newState = qc.getState();
           expectedState = ones(qc.hilbertSpaceDimension,1).*(1.0/sqrt(qc.hilbertSpaceDimension));
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

