function updatedRegister = swapGate(qregister,qubitIndex1,qubitIndex2) %#codegen
%CONTROLGATE Summary of this function goes here
%   Detailed explanation goes here
    firstQubit = qubitIndex1;
    secondQubit = qubitIndex2;
    if qubitIndex2 < qubitIndex1
        firstQubit = qubitIndex2;
        secondQubit = qubitIndex1;
    end
    numQubits = qregister.numberOfQubits;
    dimQubits = uint64(2)^(uint64(numQubits));
    
    updatedRegister = qregister;
    stateOp = 0.5 .* (speye(dimQubits) + ...
        singleGateUtil.generateTwoQubitOperator(numQubits,firstQubit,secondQubit,standardGates.X,standardGates.X) ...
        + singleGateUtil.generateTwoQubitOperator(numQubits,firstQubit,secondQubit,standardGates.Y,standardGates.Y)...
        + singleGateUtil.generateTwoQubitOperator(numQubits,firstQubit,secondQubit,standardGates.Z,standardGates.Z)...
        );
    
    if updatedRegister.isSparse
        updatedRegister.sparseQuantumState = stateOp * updatedRegister.sparseQuantumState;
    else
        updatedRegister.quantumState = full(stateOp * updatedRegister.quantumState);
    end
        
    
    updatedRegister = updatedRegister.increaseSwapGateCount(1);

end

