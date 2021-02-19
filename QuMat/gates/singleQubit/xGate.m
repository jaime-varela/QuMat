function updatedRegister = xGate(qregister,qubitIndex)
%singleQubitGate - Apply X to the qubit in the ith position
%
% Syntax: updatedRegister = xGate(qregister,qubitIndex)
%

    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.X);
end