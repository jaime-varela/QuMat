function updatedRegister = sGate(qregister,qubitIndex)
%singleQubitGate - Apply S to the qubit in the ith position
%
% Syntax: updatedRegister = sGate(qregister,qubitIndex)
%

    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.S);
end