function updatedRegister = singleQubitGate(qregister,qubitIndex,gateMatrix) %#codegen
% singleQubitGate - Apply gateMatrix to the qubit in the ith position
%
% Syntax: updatedRegister = singleQubitGate(qregister,qubitIndex,gateMatrix)
%
% Applies gateMatrix to the state and returns the register
    

%TODO: check index range and types

updatedRegister = qregister;
numQubits = qregister.numberOfQubits;

stateOperator = singleGateUtil.constructSingleGateOperator(numQubits,qubitIndex,gateMatrix);

if qregister.isSparse
    updatedRegister.sparseQuantumState = stateOperator * qregister.sparseQuantumState;
else
    updatedRegister.quantumState = full(stateOperator * qregister.quantumState);
end

updatedRegister = updatedRegister.increaseSingleGateCount(1);

end