classdef singleGateUtil %#codegen
    %#codegen
    %SINGLEGATEUTIL Utilities for single gates
    %   Can be used to construct gate arrays
    
    properties (Constant)
        % percent nonzero in matrix
        % anything above this should not be considered sparse
        SparsityThreshold = 0.7;
        
        identityThreshold = 0.00000001;        
    end
    
    methods(Static)
        function isValid = isValidGateArrayRange(numQubits,startQubit,gateArraySize) %#codegen
            %isValidGateArrayRange Returns true if the gate matrix array, start
            %index, and num qubits is valid.
            %
            %   Syntax: isValid =
            %   isValidGateArrayRange(numQubits,startQubit,gateArraySize)
            %
            numGates = gateArraySize(3);
            isValid = startQubit + numGates <= numQubits;
        end
        
        function [isSparse , numIdent] = isGateArraySparse(numQubits,gateMatrices) %#codegen
            %isGateArraySparse Returns true if the gate matrix array is
            % sparse
            %
            %   Syntax: isSparse =
            %   isGateArraySparse(numQubits,gateMatrices)
            %
            gateArraySize = size(gateMatrices);
            numGates = gateArraySize(3);
            numIdent = 0;
            for numGate = 1 : numGates
                gt = gateMatrices(:,:,numGate);
                if sum(sum(gt - eye(2) < singleGateUtil.identityThreshold)) == 0
                    numIdent = numIdent + 1;
                end
            end
            numberofZeros = nnz(~gateMatrices) + 2*(numQubits - numGates + numIdent);            
            numElements = 4*numQubits;
            isSparse = (1-(numberofZeros/numElements)) < singleGateUtil.SparsityThreshold;
        end
        
        function stateOperator = constructSingleGateOperator(numQubits,qubitIndex,gateMatrix) %#codegen
            numRemainingQubits = uint32(numQubits)-1-uint32(qubitIndex);
            dimRemainingQubits = uint64(2)^uint64(numRemainingQubits);
            dimStartQubits = uint64(2)^(uint64(qubitIndex));
            stateOperator = kron(speye(dimStartQubits),...
                kron(sparse(gateMatrix),speye(dimRemainingQubits)));
 
        end
        
      
        function [opIsSparse, fullOp, sparseOp, numNonIdentityGates] = constructGateArrayOperator(numQubits,startQubit,gateMatrices) %#codegen
            % if opIsSparse = true sparseOp is valid otherwise fullOp is
            % valid            
            
            % TODO: validate inputs

            dims = size(gateMatrices);
            numGates = dims(3);

            numRemainingQubits = numQubits-numGates-uint32(startQubit);
            dimRemainingQubits = uint64(2)^uint64(numRemainingQubits);
            dimStartQubits = uint64(2)^(uint64(startQubit));
            [opIsSparse, numIdent] = singleGateUtil.isGateArraySparse(numQubits,gateMatrices);
            numNonIdentityGates = (numGates - numIdent);
            % TODO: remove this full allocation when sparse matrices are
            % needed
            localFull = (1.0+0.0*1i)*eye(1);
            coder.varsize('localFull');
            for qubitNum = 1:numGates
                localFull = kron(localFull,...
                    gateMatrices(:,:,qubitNum));
            end

            if opIsSparse
                sparseOp = kron(speye(dimStartQubits),kron(...
                                        sparse(localFull),speye(dimRemainingQubits)));
                fullOp = (0.0+1i*0.0) .* ones(1,1);                
            else
                fullOp = kron(eye(dimStartQubits),kron(...
                                        localFull,eye(dimRemainingQubits)));
                sparseOp = sparse(1,1,0.0+1i*0.0,2^numQubits,2^numQubits);
            end
            coder.varsize('fullOp');
        end
        
        
        function gateArray = generateGateArray(varargin) %#codegen
            
            %TODO check valid inputs
            
            numGates = nargin;
            gateArray = zeros(2,2,numGates);
            for qubitNum = 1:numGates
                gateArray(:,:,qubitNum) = varargin{qubitNum};
            end
        end
        
        function stateOperator = generateTwoQubitOperator(numQubits,firstQubit,secondQubit,op1,op2)
            % Todo validate inputs
            numRemainingQubits = numQubits-1- secondQubit;
            dimRemainingQubits = uint64(2)^uint64(numRemainingQubits);
            dimStartQubits = uint64(2)^(uint64(firstQubit));
            dimMidQubits = uint64(2)^uint64(secondQubit - firstQubit -1);
            
            startIden = speye(dimStartQubits);
            midIden = speye(dimMidQubits);
            endIden = speye(dimRemainingQubits);
            stateOperator = kron(kron(startIden , kron(sparse(op1) , midIden) ), kron(sparse(op2) , endIden));
        end
    end
end

