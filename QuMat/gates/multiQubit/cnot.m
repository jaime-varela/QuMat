function updatedRegister = cnot(qregister,controlQubit,targetQubit) %#codegen
%CONTROLGATE Summary of this function goes here
%   Detailed explanation goes here
    updatedRegister = controlGate(qregister,controlQubit,targetQubit,...
        standardGates.X);
    updatedRegister = updatedRegister.increaseCNotGateCount(1);

end

