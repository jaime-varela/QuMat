function updatedRegister = hGate(qregister,qubitIndex)
%singleQubitGate - Apply H (hadamard) to the qubit in the ith position
%
% Syntax: updatedRegister = hGate(qregister,qubitIndex)
%

    gate = standardGates.H;
    updatedRegister = singleQubitGate(qregister,qubitIndex,gate);
end
