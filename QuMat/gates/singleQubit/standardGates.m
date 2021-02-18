classdef standardGates
    %STANDARDGATES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        H = [1 1;1 -1] .* (1/sqrt(2));
        S = [1 0;0 1.0*1i];
        Sdag = [1 0;0 -1.0*1i];
        T = [1 0;0 exp(1i*pi/4)];
        Tdag=[1 0;0 exp(-1i*pi/4)];
        X = [0 1;1 0];
        Y = [0 -1.0*1i;1.0*1i 0];
        Z = [1 0;0 -1];
        Flip = [0 1;1 0];
        ProjectZero = [1.0+0.0*1i 0;0.0 0.0];
        ProjectOne = [0 0;0.0 1.0+0.0*1i];
        Id = [1.0+0.0*1i 0;0.0 1.0+0.0*1i];
    end
    
    methods(Static)
        function RmGate = Rm(m)
            RmGate = [1 0 ; 0 exp(2*pi*1i/(2^m))];
        end
        
        function phGate = phaseGate(phase)
            phGate = [1 0; 0 cos(phase) + 1i* sin(phase)];
        end
                
        function rotationGate = rotationGate(nx,ny,nz,theta) %#codegen

            % TODO: check inputs
            rotationGate = cos(theta/2) .* eye(2) + 1i*sin(theta/2) .* ...
                (nx .* X + ny .* Y + nz .* Z);
        end
        function rotx = rotX(theta)
            rotx = standardGates.rotationGate(1,0,0,theta);
        end
        function roty = rotY(theta)
            roty = standardGates.rotationGate(0,1,0,theta);
        end
        function rotz = rotZ(theta)
            rotz = standardGates.rotationGate(0,0,1,theta);
        end
        
    end
end

