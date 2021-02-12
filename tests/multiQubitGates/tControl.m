classdef tControl < matlab.unittest.TestCase
    %TINITIALIZATION Summary of this class goes here
    %   Detailed explanation goes here
        
    methods (Test)
        function tCnot(testCase)
            qcInit = qregister(0,1,0);
            qcInit = cnotGate(qcInit,1,2);            
            qcExpected = qregister(0,1,1);
            newState = qcInit.getState();
            expectedState = qcExpected.getState();
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end

        function tCnot2(testCase)
            qcInit = qregister(0,1,0,1);
            qcInit = cnotGate(qcInit,2,3);      
            qcExpected = qregister(0,1,0,1);
            newState = qcInit.getState();
            expectedState = qcExpected.getState();
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        function tCnot3(testCase)
            qcInit = qregister(0,1,0,1);
            qcInit = cnotGate(qcInit,1,2);      
            qcExpected = qregister(0,1,1,1);
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

