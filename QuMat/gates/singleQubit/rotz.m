function updatedRegister = rotz(qregister,qubitIndex,theta)
%singleQubitGate - Apply rotZ to the qubit in the ith position
%
% Syntax: updatedRegister = rotz(qregister,qubitIndex,theta)
%

    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.rotZ(theta));
end