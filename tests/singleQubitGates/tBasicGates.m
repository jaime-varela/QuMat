classdef tBasicGates < matlab.unittest.TestCase
    %TINITIALIZATION X gate
        
    methods (Test)
        function tX0X3T3(testCase)
            qc = qregister(4);
            qc = xGate(qc,0);
            qc = xGate(qc,3);
            qc = tGate(qc,3);

            newState = qc.getState();
            expectedState = zeros(16,1);
            expectedState(binaryNumberUtil.binaryNumberToDecimal(1,0,0,1)+1) = exp(1i*pi/4);
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

