function updatedRegister = yGate(qregister,qubitIndex)
%singleQubitGate - Apply Y to the qubit in the ith position
%
% Syntax: updatedRegister = yGate(qregister,qubitIndex)
%

    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.Y);
end