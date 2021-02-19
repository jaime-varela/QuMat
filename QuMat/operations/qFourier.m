function updatedRegister = qFourier(Qregister,varargin)
%QFOURIER Quantum fourier stransform
%   Apply the quantum fourier transform
%
%   Syntax: updatedRegister = qFourier(Qregister)
%          apply fourier transform on the entire register
%
%   Syntax: updatedRegister = qFourier(Qregister,startInd,endInd)
%          apply fourier transform for the qubits [startInd ... endInd]
%
%   Syntax: updatedRegister = qFourier(Qregister,indexArray)
%          apply fourier transform to the qubits in the index array
%

%TODO validate inputs

if nargin == 3
    % start and stop indices
    qubitIndexArray = varargin{1}:varargin{2};
elseif nargin == 2
   % index array 
   qubitIndexArray = varargin{1};
else
    % all qubit case
    qubitIndexArray = 0:Qregister.numberOfQubits - 1;
end

qubitIndexArray = sort(qubitIndexArray);
numQubits = size(qubitIndexArray,2);

updatedRegister = Qregister;
for qubitInd = 0:numQubits-1
    updatedRegister = hGate(updatedRegister,qubitIndexArray(qubitInd+1));
    counter = 2;
    for cnotQubit = qubitInd+1:numQubits-1
       updatedRegister = controlGate(updatedRegister,qubitIndexArray(cnotQubit+1),...
           qubitIndexArray(qubitInd+1),standardGates.Rm(counter)); 
       counter = counter +1;
    end
end

% swap gate stage
for qubit = 0:floor(numQubits/2) -1
   if qubit ~= numQubits - qubit -1
       updatedRegister = swapGate(updatedRegister,qubitIndexArray(qubit+1),...
           qubitIndexArray(numQubits - qubit)); 
   end
end


end

