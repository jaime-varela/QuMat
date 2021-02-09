classdef singleGateUtil %#codegen
    %#codegen
    %SINGLEGATEUTIL Utilities for single gates
    %   Can be used to construct gate arrays
    
    properties (Constant)
        % percent nonzero in matrix
        % anything above this should not be considered sparse
        SparsityThreshold = 0.7;
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
        
        function isSparse = isGateArraySparse(gateMatrices) %#codegen
            %isGateArraySparse Returns true if the gate matrix array is
            % sparse
            %
            %   Syntax: isSparse =
            %   isGateArraySparse(numQubits,gateMatrices)
            %
            gateArraySize = size(gateMatrices);
            numGates = gateArraySize(3);
            numberofZeros = nnz(~gateMatrices);
            numElements = 4*numGates;
            isSparse = (1-(numberofZeros/numElements)) < singleGateUtil.SparsityThreshold;
        end
        
        function stateOperator = constructSingleGateOperator(numQubits,qubitIndex,gateMatrix) %#codegen
            numRemainingQubits = numQubits-1-uint32(qubitIndex);
            dimRemainingQubits = uint32(2)^numRemainingQubits;
            dimStartQubits = uint32(2)^(uint32(qubitIndex));
            stateOperator = kron(speye(dimStartQubits),...
                kron(sparse(gateMatrix),speye(dimRemainingQubits)));
 
        end
        
        function identityMatrix = identityGate(isSparseGateArray,dim) %#codegen
            if isSparseGateArray
                identityMatrix = speye(dim);
            else
                identityMatrix = eye(dim);
            end
        end
        
        function updatedGate = getSparseGateIfNeeded(isSparse,gate) %#codegen
           if isSparse
               localVar = sparse(gate);
           else
               localVar = gate;
           end
           coder.varsize('localVar',[inf inf]);
           updatedGate = localVar;
        end
        
        function [stateOperator, numGates] = constructGateArrayOperator(numQubits,startQubit,gateMatrices) %#codegen

            % TODO: pre-allocate for performance gains
             dims = size(gateMatrices);
             numGates = dims(3);

             numRemainingQubits = numQubits-numGates-uint32(startQubit);
             dimRemainingQubits = uint32(2)^numRemainingQubits;
             dimStartQubits = uint32(2)^(uint32(startQubit));
%             stateOperator = kron(speye(dimStartQubits,dimStartQubits),...
%                 kron(sparse(gateMatrix),speye(dimRemainingQubits,dimRemainingQubits)));
            
            stateOperator = kron(speye(dimStartQubits),kron(...
                singleGateUtil.tensorgateMatrices(gateMatrices),speye(dimRemainingQubits)));            
                        
        end
        
        function tensorOp = tensorgateMatrices(gateMatrices) %#codegen
            dims = size(gateMatrices);
            numGates = dims(3);
            gateOperator = eye(1);
            isSparseGateArray = singleGateUtil.isGateArraySparse(gateMatrices);
            
            for qubitNum = 1:numGates
                gateOperator = kron(gateOperator,...
                    singleGateUtil.getSparseGateIfNeeded(isSparseGateArray,gateMatrices(:,:,qubitNum)));
            end
            tensorOp = gateOperator;
        end
        
        
        %function gateArray = generateGateArray(varargin) %#codegen

        
    end
end

