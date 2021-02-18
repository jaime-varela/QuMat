function hadamardRegister = hadamardRegister(numQubits)
%HADAMARDREGISTER Summary of this function goes here
%   Detailed explanation goes here

hadamardRegister = qregister(numQubits);
hadamardRegister = singleGateUtil.applyToEach(hadamardRegister,standardGates.H);

end

