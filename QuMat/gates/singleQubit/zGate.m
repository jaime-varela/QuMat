function updatedRegister = xGate(qregister,qubitIndex)
%singleQubitGate - Apply X to the qubit in the ith position
%
% Syntax: updatedRegister = singleQubitGate(qregister,qubitIndex,gateMatrix)
%
% Applies [...] to the state and returns the register
    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.Z);
end