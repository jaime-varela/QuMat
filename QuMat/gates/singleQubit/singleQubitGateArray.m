function updatedRegister = singleQubitGateArray(qregister,varargin) %#codegen
% singleQubitGateArray - Apply the array of single qubit gates 
%
% Syntax: updatedRegister = singleQubitGateArray(qregister,gateMatrices)
%
%     applies gateMatrices(:,:,i) to the (i-1)-th qubit.
%     The dimensions of gateMatrices satisfies
%
%       size(gateMatrices,1) < qregister.numberOfQubits
%       size(gateMatrices,2) = size(gateMatrices,3) = 2
%
% Syntax: updatedRegister = singleQubitGateArray(qregister,qubitStartIndex,gateMatrices)
%
%     applies gateMatrices(:,:,i) to the (qubitStartIndex + i - 1)-th qubit.
%     The dimensions of gateMatrices satisfies
%
%       size(gateMatrices,1) + qubitStartIndex < qregister.numberOfQubits
%       size(gateMatrices,1) = size(gateMatrices,2) = 2
%

%TODO: check index range and types

startQubit = 0;
coder.varsize('gateMatrices',[2 2 inf]);

if (nargin - 1) == 2
    startQubit = varargin{1};
    gateMatrices = varargin{2};
else
    gateMatrices = varargin{1};
end


gateDims = size(gateMatrices);
numQubits = qregister.numberOfQubits;
coder.varsize('gateDims',[1 3]);
isValid = singleGateUtil.isValidGateArrayRange(numQubits,startQubit,gateDims);

if ~isValid
    error('Not a valid gate array');
end

updatedRegister = qregister;
[stateOperator, numNonIdentityGates] = singleGateUtil.constructGateArrayOperator(numQubits,startQubit,gateMatrices);

if updatedRegister.isSparse
    updatedRegister.sparseQuantumState = stateOperator * qregister.sparseQuantumState;
else
    updatedRegister.quantumState = stateOperator * qregister.quantumState;
end

updatedRegister = updatedRegister.increaseSingleGateCount(numNonIdentityGates);

if updatedRegister.shouldUpdateSparsity()
    updatedRegister = updatedRegister.updateSparsity();
end

end
