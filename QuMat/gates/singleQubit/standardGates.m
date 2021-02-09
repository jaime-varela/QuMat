classdef standardGates
    %STANDARDGATES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        H = [1 1;1 -1] .* (1/sqrt(2));
        S = [1 0;0 1.0*1i];
        T = [1 0;0 exp(1i*pi/4)];
        X = [0 1;1 0];
        Y = [0 -1.0*1i;1.0*1i 0];
        Z = [1 0;0 -1];
        Flip = [0 1;1 0];
    end
    
    methods(Static)
        
        function phGate = phaseGate(phase)
            phGate = [1 0; 0 cos(phase) + 1i* sin(phase)];
        end
        
    end
end

