classdef tBellPair < matlab.unittest.TestCase
    %TINITIALIZATION Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Test)
        
        function tBellPairConstruction(testCase)
            import matlab.unittest.constraints.IsEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            import matlab.unittest.constraints.RelativeTolerance
            
            b00 = bellPair(0,0);
            b00State = b00.getState();
            expected = 1.0/sqrt(2.0) .* [1; 0;0;1];
            tolObj = AbsoluteTolerance(1.0e-10) & RelativeTolerance(1.0e-10);            
            testCase.verifyThat(b00State,IsEqualTo(expected,'Within',tolObj()));                

            b01 = bellPair(0,1);
            b01State = b01.getState();
            expected = 1.0/sqrt(2.0) .* [0; 1;1;0];
            testCase.verifyThat(b01State,IsEqualTo(expected,'Within',tolObj()));                
            
            b10 = bellPair(1,0);
            b10State = b10.getState();
            expected = 1.0/sqrt(2.0) .* [1; 0;0;-1];
            testCase.verifyThat(b10State,IsEqualTo(expected,'Within',tolObj()));                

            b11 = bellPair(1,1);
            b11State = b11.getState();
            expected = 1.0/sqrt(2.0) .* [0; 1;-1;0];
            testCase.verifyThat(b11State,IsEqualTo(expected,'Within',tolObj()));                
            
        end

        
    end
end

