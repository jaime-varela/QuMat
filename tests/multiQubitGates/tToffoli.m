classdef tToffoli < matlab.unittest.TestCase
    %TINITIALIZATION Summary of this class goes here
    %   Detailed explanation goes here
        
    methods (Test)
        function tTofolli(testCase)
            qcInit = qregister(1,1,0);
            qcInit = toffoliGate(qcInit,0,1,2);            
            qcExpected = qregister(1,1,1);
            newState = qcInit.getState();
            expectedState = qcExpected.getState();
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        function tTofolli2(testCase)
            qcInit = qregister(1,0,0);
            qcInit = toffoliGate(qcInit,0,1,2);            
            qcExpected = qregister(1,0,0);
            newState = qcInit.getState();
            expectedState = qcExpected.getState();
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        function tTofolli3(testCase)
            qcInit = qregister(1,1,1);
            qcInit = toffoliGate(qcInit,0,1,2);            
            qcExpected = qregister(1,1,0);
            newState = qcInit.getState();
            expectedState = qcExpected.getState();
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                
        end
        function tTofolli4(testCase)
            qcInit = qregister(0,0,1);
            qcInit = toffoliGate(qcInit,0,1,2);            
            qcExpected = qregister(0,0,1);
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
            % Absolute tolerance is better because array is normalized,
            % relative tolerance has issues near zero
            tolObj = AbsoluteTolerance(1.0e-12);
        end
    end
end

