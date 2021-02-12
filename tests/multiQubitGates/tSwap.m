classdef tSwap < matlab.unittest.TestCase
    %TINITIALIZATION Summary of this class goes here
    %   Detailed explanation goes here
        
    methods (Test)
        function tBasicSwap(testCase)
            qcInit = qregister(0,1,0,0);
            qcInit = swapGate(qcInit,1,3);
            qcExpected = qregister(0,0,0,1);

            newState = qcInit.getState();
            expectedState = qcExpected.getState();
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end

        function tBasicSwap2(testCase)
            qcInit = qregister(0,0,0,1);
            qcInit = swapGate(qcInit,1,3);
            qcExpected = qregister(0,1,0,0);

            newState = qcInit.getState();
            expectedState = qcExpected.getState();
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        function tBasicSwap3(testCase)
            qcInit = qregister(0,1,1,0);
            qcInit = swapGate(qcInit,1,3);
            qcExpected = qregister(0,0,1,1);

            newState = qcInit.getState();
            expectedState = qcExpected.getState();
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        function tBasicSwap4(testCase)
            qcInit = qregister(0,1,1,0);
            qcInit = swapGate(qcInit,2,3);
            qcExpected = qregister(0,1,0,1);

            newState = qcInit.getState();
            expectedState = qcExpected.getState();
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        function tBasicSwap5(testCase)
            qcInit = qregister(0,1,1,0);
            qcInit = swapGate(qcInit,0,1);
            qcExpected = qregister(1,0,1,0);

            newState = qcInit.getState();
            expectedState = qcExpected.getState();
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

