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
[opIsSparse, fullOp, sparseOp, numNonIdentityGates] = singleGateUtil.constructGateArrayOperator(numQubits,startQubit,gateMatrices);
% split up the sparse construction (one function can't construct two types
% or create multiple outputs)
if updatedRegister.isSparse
    if opIsSparse
        updatedRegister.sparseQuantumState = sparseOp * qregister.sparseQuantumState;
    else
        updatedRegister.quantumState = fullOp * qregister.sparseQuantumState;        
        % no longer sparse
        updatedRegister.isSparse = false;
        updatedRegister.sparseQuantumState = sparse(1,1,0.0+0.0*1i,updatedRegister.hilbertSpaceDimension,1);
    end
else
    if opIsSparse
        updatedRegister.quantumState = sparseOp * qregister.quantumState;
    else
        updatedRegister.quantumState = fullOp * qregister.quantumState;        
    end
end

updatedRegister = updatedRegister.increaseSingleGateCount(numNonIdentityGates);

if updatedRegister.shouldUpdateSparsity()
    updatedRegister = updatedRegister.updateSparsity();
end

end
