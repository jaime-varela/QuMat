function hadamardRegister = hadamardRegister(numQubits)
%HADAMARDREGISTER Creates a hadamard register with numQubits
%   Generate the hadamard state
%
%   Syntax: hregister = hadamardRegister(numQubits)
%      hregister is a hadamard quantum register

hadamardRegister = qregister(numQubits);
hadamardRegister = singleGateUtil.applyToEach(hadamardRegister,standardGates.H);

end

