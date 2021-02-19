function updatedRegister = zGate(qregister,qubitIndex)
%singleQubitGate - Apply Z to the qubit in the ith position
%
% Syntax: updatedRegister = zGate(qregister,qubitIndex)
%

    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.Z);
end