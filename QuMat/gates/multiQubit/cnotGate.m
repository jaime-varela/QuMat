function updatedRegister = cnotGate(qregister,controlQubit,targetQubit) %#codegen
%CONTROLGATE Summary of this function goes here
%   Detailed explanation goes here

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

