function updatedRegister = tGate(qregister,qubitIndex)
%singleQubitGate - Apply T to the qubit in the ith position
%
% Syntax: updatedRegister = tGate(qregister,qubitIndex)
%

    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.T);
end