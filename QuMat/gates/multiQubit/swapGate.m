function updatedRegister = swapGate(qregister,qubitIndex1,qubitIndex2) %#codegen
%CONTROLGATE Summary of this function goes here
%   Detailed explanation goes here
    
    % swap gate is three cnot gates
    updatedRegister = cnotGate(qregister,qubitIndex1,qubitIndex2);
    updatedRegister = cnotGate(updatedRegister,qubitIndex2,qubitIndex1);
    updatedRegister = cnotGate(updatedRegister,qubitIndex1,qubitIndex2);
        
    
    updatedRegister = updatedRegister.increaseSwapGateCount(1);

end

