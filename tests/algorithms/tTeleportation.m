classdef tTeleportation < matlab.unittest.TestCase
    %TINITIALIZATION Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Test)
        function tTeleportQubit(testCase)
            % create entangled resource
            entangleRegister = qregister(2,0);
            entangleRegister = hGate(entangleRegister,0);
            entangleRegister = cnotGate(entangleRegister,0,1);

            % initial state (qregister does the normalization)
            randVec = [(rand() + 1i*rand()); (rand() +1i*rand())];
            initialQubit = qregister(randVec);

            % store the state for later analysis
            expectedState = initialQubit.getState();

            % Concatenate the registers (initial qubit is in the first index)
            register = initialQubit.concatenateRegiser(entangleRegister);

            register = cnotGate(register,0,1);
            register = hGate(register,0);

            % perform destructive measurements on the first two qubits
            % passing in true means the other qubits are thrown out and the hilbert
            % space dimension is reduced
            [finalQubit, measurmements] = measure_sequence(register,[0,1],true);

            % selectively apply gates on states
            if measurmements(2) == 1
                finalQubit = xGate(finalQubit,0);
            end
            if measurmements(1) == 1
                finalQubit = zGate(finalQubit,0);
            end

            % The final state is
            newState = finalQubit.getState();
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
    end
    
end

