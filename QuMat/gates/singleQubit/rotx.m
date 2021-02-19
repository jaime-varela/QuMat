function updatedRegister = rotx(qregister,qubitIndex,theta)
%singleQubitGate - Apply rotx to the qubit in the ith position
%
% Syntax: updatedRegister = rotx(qregister,qubitIndex,theta)
%

    updatedRegister = singleQubitGate(qregister,qubitIndex,standardGates.rotX(theta));
end