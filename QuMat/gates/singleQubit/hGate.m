function updatedRegister = hGate(qregister,qubitIndex)
%singleQubitGate - Apply H (hadamard) to the qubit in the ith position
%
% Syntax: updatedRegister = singleQubitGate(qregister,qubitIndex,gateMatrix)
%
% Applies H gate to the state and returns the register
    gate = standardGates.H;
    updatedRegister = singleQubitGate(qregister,qubitIndex,gate);
end
