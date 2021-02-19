function updatedRegister = cnotGate(qregister,controlQubit,targetQubit) %#codegen
%CONTROLGATE Cnot gate
%   Standard Cnot gate on two qubits

    if controlQubit == targetQubit
       error('Control qubit can not be the same as target');
    end

    updatedRegister = qregister;
    if controlQubit > targetQubit
        updatedRegister = hGate(updatedRegister,controlQubit);
        updatedRegister = hGate(updatedRegister,targetQubit);
        updatedRegister = cnotGate(updatedRegister,targetQubit,controlQubit);
        updatedRegister = hGate(updatedRegister,controlQubit);
        updatedRegister = hGate(updatedRegister,targetQubit);
        return;
    end

    updatedRegister = controlGate(updatedRegister,controlQubit,targetQubit,...
        standardGates.X);
    updatedRegister = updatedRegister.increaseCNotGateCount(1);

end

