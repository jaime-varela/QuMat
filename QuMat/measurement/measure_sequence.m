function [updatedRegister,varargout ] = measure_sequence(qregister,varargin)
%MEASURE_SEQUENCE Measure qubits in the |0> |1> basis
%   Will sequentially perform measurments of the qubits in the 
%   locations specified in the index array
%
%   Syntax: measure_sequence(qregister,indexVector)
%       
%       measure the qubits in the index vector and not reduce the hilbert
%       space dimension
%   
%  Syntax: measure_sequence(qregister,indexVector,isDestructiveMeasure)
%       
%      will reduce the hilbert space dimension if isDestructiveMeasure =
%      true
%
%  Outputs:
%         [updatedRegister, measurementResults]
%         [updatedRegister, measurementResults, probabilities]
%      where updatedRegister is the register state after measurement
%      sequence, measurementResults are the measurements obtained, and
%      probabilities are the probabilities for each measurement (typically
%      not obtainable via a single measurement).

shouldReduceH = false;
if nargin == 3
    shouldReduceH = varargin{2};
end

indexVector = varargin{1};

dimsIndex = size(indexVector);
numMeasured = dimsIndex(2);
intermediateRegister = qregister;
results = zeros(1,numMeasured);
probabilities = zeros(1,numMeasured);
for qubit = 1:numMeasured
    qubitIndex = indexVector(qubit);
    [intermediateRegister, result, prob] = measure_qubit(intermediateRegister,qubitIndex,shouldReduceH);
    results(qubit) = result;
    for qubitMeasureIndex = 1:numMeasured
       if indexVector(qubitMeasureIndex) > qubitMeasureIndex
           indexVector(qubitMeasureIndex) = indexVector(qubitMeasureIndex) - 1;
       end
    end
    probabilities(qubit) = prob;    
end

updatedRegister = intermediateRegister;
varargout{1} = results;
if nargout == 3
   varargout{2} = probabilities; 
end

end

