function [updatedRegister,varargout ] = measure_qubit(qregister,varargin) %#codegen
%MEASURE_QUBIT Single qubit measurement
%
%   Syntax: measure_qubit(qregister,qubitIndex)
%
%      will measure the qubit in the qubitIndex location non-destructively
%
%   Syntax: measure_qubit(qregister,qubitIndex,isDestructive)
%      
%      will reduce the hilbert space dimension if isDestructiveMeasure =
%      true
%
%  Outputs:
%  [updatedRegister, result, probability]


% TODO refactor this
updatedRegister = qregister;

shouldReduceH = false;
if nargin == 3
    shouldReduceH = varargin{2};
end

qubitIndex = varargin{1};
numQubits = qregister.numberOfQubits;
opZero = singleGateUtil.constructSingleGateOperator(numQubits,qubitIndex,standardGates.ProjectZero);
finalOp = opZero;
if updatedRegister.isSparse
    zeroStateUnormalized = full(opZero * updatedRegister.sparseQuantumState);
else
    zeroStateUnormalized = opZero * updatedRegister.quantumState;
end


probabilityZero = conj(transp(zeroStateUnormalized)) * zeroStateUnormalized;
if nargout == 3
    varargout{2} = probabilityZero;
end

aRandNumber = rand();
isZeroSelected = aRandNumber < probabilityZero;
if isZeroSelected
    newStateUnreduced = zeroStateUnormalized ./ probabilityZero;
    varargout{1} = 0;
else
    opOne = singleGateUtil.constructSingleGateOperator(numQubits,qubitIndex,standardGates.ProjectOne);
    finalOp = opOne;
    if updatedRegister.isSparse
        oneStateUnormalized = full(opOne * updatedRegister.sparseQuantumState);
    else
        oneStateUnormalized = opOne * updatedRegister.quantumState;
    end    
    newStateUnreduced = oneStateUnormalized ./ (1- probabilityZero);
    varargout{1} = 1;
end

    %TODO figure out way to leverage sparsity

if shouldReduceH
    dummyState = finalOp * ones(updatedRegister.hilbertSpaceDimension,1);
    newState = newStateUnreduced(dummyState ~= 0);    
else
    newState = newStateUnreduced;
end
% TODO create an update state in order to not destroy the gate information
updatedRegister.numberOfMeasurementsApplied = qregister.numberOfMeasurementsApplied + 1;
updatedRegister = updatedRegister.setLexicographicState(newState);


end

