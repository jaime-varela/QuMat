function updatedRegister = rotation(qregister,qubitIndex,nx,ny,nz,theta)
%singleQubitGate - Apply X to the qubit in the ith position
%
% Syntax: updatedRegister = singleQubitGate(qregister,qubitIndex,nx,ny,nz,theta)
%
%    Standard rotation formula for unit vector
%

%TODO: check inputs

    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.rotationGate(nx,ny,nz,theta));
end