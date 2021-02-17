function hadamardRegister = hadamardRegister(numQubits)
%HADAMARDREGISTER Summary of this function goes here
%   Detailed explanation goes here
hadamardRegister = qregister(numQubits);
gateArray = zeros(2,2,numQubits);

for qubitNum = 1:numQubits
    gateArray(:,:,qubitNum) = standardGates.H;    
end
hadamardRegister = singleQubitGateArray(hadamardRegister,gateArray);

end

