function updatedRegister = rotation(qregister,qubitIndex,nx,ny,nz,theta)
%singleQubitGate - Apply X to the qubit in the ith position
%
% Syntax: updatedRegister = singleQubitGate(qregister,qubitIndex,gateMatrix)
%
% Applies [...] to the state and returns the register
    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.rotationGate(nx,ny,nz,theta));
end