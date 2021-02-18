classdef tFourierTransform < matlab.unittest.TestCase
    
    methods (Test)
        function tFourier4Qubit(testCase)
            n = 4;
            randomRegister = randRegister(n);
            
            qftMatrix = testCase.Fn(n);
            expectedState = qftMatrix * randomRegister.getState();
            % Apply the transform
            qftRegister = qFourier(randomRegister);
            newState = qftRegister.getState();
            
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                                    
        end

        function tFourier5Qubit(testCase)
            n =5;
            randomRegister = randRegister(n);
            
            qftMatrix = testCase.Fn(n);
            expectedState = qftMatrix * randomRegister.getState();
            % Apply the transform
            qftRegister = qFourier(randomRegister);
            newState = qftRegister.getState();
            
            import matlab.unittest.constraints.IsEqualTo
            testCase.verifyThat(newState,IsEqualTo(expectedState,'Within',testCase.getTolObj()));                                    
        end
        
    end
    methods (Static)
        % to do move this to a test util
        function tolObj = getTolObj()
            import matlab.unittest.constraints.AbsoluteTolerance
            % Absolute tolerance is better because array is normalized,
            % relative tolerance has issues near zero
            tolObj = AbsoluteTolerance(1.0e-12);
        end
        % see wikipedia formula
        function FN = Fn(n)
            N = 2^n;
            omega = exp(2*pi*1i/N);
            FN = ones(N);
            for i = 2:N
                for j = 2:N
                    FN(i,j) = power(omega,(i-1)*(j-1));   
                end
            end
            FN = (1/sqrt(N)) .* FN;
            
        end
    end
    
end

