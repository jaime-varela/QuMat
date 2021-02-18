function updatedRegister = qFourier(Qregister)
%QFOURIER Summary of this function goes here
%   Detailed explanation goes here
numQubits = Qregister.numberOfQubits;
updatedRegister = Qregister;
for qubitInd = 0:numQubits-1
    updatedRegister = hGate(updatedRegister,qubitInd);
    counter = 2;
    for cnotQubit = qubitInd+1:numQubits-1
       updatedRegister = controlGate(updatedRegister,cnotQubit,qubitInd,standardGates.Rm(counter)); 
       counter = counter +1;
    end
end

% swap gate stage
for qubit = 0:floor(numQubits/2) -1
   if qubit ~= numQubits - qubit -1
       updatedRegister = swapGate(updatedRegister,qubit,numQubits - qubit - 1); 
   end
end


end

