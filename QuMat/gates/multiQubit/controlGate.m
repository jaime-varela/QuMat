function updatedRegister = controlGate(qregister,controlQubit, targetQubit,operation)
%CONTROLGATE Summary of this function goes here
%   Detailed explanation goes here
if controlQubit == targetQubit
    error('target and control must be different')
end

numQubits = qregister.numberOfQubits;
stateOperator = multiGateUtil.constructControlOperator(numQubits,controlQubit,targetQubit,operation);
updatedRegister = qregister;
if updatedRegister.isSparse
    updatedRegister.sparseQuantumState = stateOperator * updatedRegister.sparseQuantumState;
else
    updatedRegister.quantumState = full(stateOperator * updatedRegister.quantumState);
end

updatedRegister = updatedRegister.increaseCTRLGateCount(1);
    
end
