function updatedRegister = roty(qregister,qubitIndex,theta)
%singleQubitGate - Apply roty to the qubit in the ith position
%
% Syntax: updatedRegister = roty(qregister,qubitIndex)
%

    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.rotY(theta));
end