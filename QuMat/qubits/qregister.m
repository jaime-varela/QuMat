classdef qregister < handle
    %qregister a quantum register
    %   A quantum register object
    
    properties
        % number of qubits in register
        
        % a sparse array is generated under certain conditions
        sparseQuantumState;
        
        % the full lexicographical state array
        quantumState;
        isSparse = false;

        numberOfQubits = uint32(2);

        numberOfSingleGatesApplied = uint64(0);
        
        numberOfCnotGatesApplied = uint64(0);
        
        numberOfControlGates = uint64(0);
        
        numberOfSwapGates = uint64(0);

        % kept as double as sometimes you need to write 1/sqrt(hdim)
        hilbertSpaceDimension = 4;

        % used to keep track of when we need to check sparsity
        sparseThresholdCheck = uint64(0);
        
        % number of measurements performed on qubits
        numberOfMeasurementsApplied = uint64(0);
    end
    
    methods
        function obj = qregister(varargin) %#codegen
            %qregister Constructor of a register
            %  The options are
            %  qregister(numQubits) -> creates a qubit register with numQubits qubits
            %  in the |0>|0>... state.
            %
            %  qregister(numQubits, stateInt) -> creates a qubit register in
            %  state |stateInt> (note: 0 < stateInt < numQubits)
            %
            %  qregister(0,1,0, ...) -> creates a qubit register
            %  in the |0>|1>|0>... product state.  The number of qubits
            %  must be greater than 2 for this method to be called.
            %
            % qregister(complexArray) -> creates a qubit register in the state defined by
            % the complex array and will normalized if needed.
            
            if nargin == 1 && isscalar(varargin{1})
                obj.numberOfQubits = uint32(varargin{1});
                obj.isSparse = true;
                obj.sparseQuantumState = sparse(1,1,1+0.0*1i,2^obj.numberOfQubits,1);
                obj.hilbertSpaceDimension = 2^varargin{1};   
                % dummy quantum state for codegen compatibility
                localVar = 1i*ones(varargin{1},int32(1));
                coder.varsize('localVar',[inf 1]);

                % we keep the  quantum state first dim variable as we may
                % not need to allocate the full state.
                obj.quantumState = localVar;
            elseif nargin == 1
                % Todo: check input dim factor of two
                dims = size(varargin{1});
                [hdim, index] = max(dims);
                inputVec = (1.0+0.0*1i).* varargin{1};
                if index == 2
                    stateVec = transpose(inputVec)/norm(transpose(inputVec));
                else
                    stateVec = inputVec/norm(inputVec);
                end
                
                if nnz(stateVec) / (1.0*obj.hilbertSpaceDimension) < 0.7
                    obj.sparseQuantumState = sparse(stateVec);
                    obj.hilbertSpaceDimension = uint64(hdim);
                    obj.numberOfQubits = uint32(log2(hdim));
                    obj.isSparse = true;
                    % dummy quantum state for codegen compatibility
                    localVar = 1i*ones(obj.numberOfQubits,int32(1));
                    coder.varsize('localVar',[inf 1]);

                    % we keep the  quantum state first dim variable as we may
                    % not need to allocate the full state.
                    obj.quantumState = localVar;                
                else
                    obj.quantumState = stateVec;
                    obj.hilbertSpaceDimension = uint64(hdim);
                    obj.numberOfQubits = uint32(log2(hdim));
                    obj.isSparse = false;
                    % zero state for the sparse state
                    obj.sparseQuantumState = sparse(1,1,0+0.0*1i,2^obj.numberOfQubits,1);                    
                end
            elseif nargin == 2
                obj.numberOfQubits = uint32(varargin{1});
                obj.isSparse = true;
                obj.sparseQuantumState = sparse(varargin{2}+1,1,1+0.0*1i,2^obj.numberOfQubits,1);
                obj.hilbertSpaceDimension = uint64(uint64(2)^uint64(varargin{1}));   
                % dummy quantum state for codegen compatibility
                localVar = 1i*ones(varargin{1},int32(1));
                coder.varsize('localVar',[inf 1]);

                % we keep the  quantum state first dim variable as we may
                % not need to allocate the full state.
                obj.quantumState = localVar;                
            else
                obj = qregister(nargin,binaryNumberUtil.binaryNumberToDecimal(varargin{:}));
            end
            
        end
        
        function state = getState(obj) %#codegen
            %getState Get the current state of the register
            %   Current state of the register in lexicographical order
            if obj.isSparse
                state = full(obj.sparseQuantumState);
                return;
            end
            state = obj.quantumState;
        end
        
        function obj = concatenateRegiser(obj,aRegister) %#codegen
            % concatenateRegiser Combines registers in a product state
            %    if the register of the class is
            %    $\sum_i a_i |i\rangle$
            %    and the input register state is
            %    $\sum_j b_j |j\rangle$ 
            %    the new register state is
            %    $\left(\sum_i a_i |i\rangle\right)\left(\sum_j b_j |j\rangle\right)$    
            
            % TODO : type checks
                        
            firstState = obj.getState();
            secondState = aRegister.getState();
            productState = kron(firstState, secondState);
            obj = qregister(productState);
        end

        function obj = updateSparsity(obj) %#codegen
        %updateSparsity - updates the sparsity as needed
        %
        % Syntax: obj = updateSparsity(obj)
        %
        % If the number of non-zero states in the sparse aray is above a certain percentage
        % this method changes the object to be non sparse.
        if ~obj.isSparse
            return;
        end

        if nnz(obj.sparseQuantumState) / (1.0*obj.hilbertSpaceDimension) > 0.7
            obj.isSparse = false;
            % switch to full state
            obj.quantumState = reshape(full(obj.sparseQuantumState),...
                obj.hilbertSpaceDimension,1);
            %obj.quantumState = zeros(obj.hilbertSpaceDimension,1);
            % set the sparse state to the zero state
            obj.sparseQuantumState = sparse(1,1,0.0+0.0*1i,2^obj.numberOfQubits,1);
        end
        obj.sparseThresholdCheck = uint64(0);
        end
        
        function shouldUpdate = shouldUpdateSparsity(obj) %#codegen
            % deciding function to know if we should run updateSparsity()
            shouldUpdate = obj.isSparse && obj.sparseThresholdCheck > 100 * obj.numberOfQubits;
        end

        function obj = increaseSingleGateCount(obj,numGates) %#codegen
            % increases the number of gates
            obj.numberOfSingleGatesApplied = obj.numberOfSingleGatesApplied + uint64(numGates);
            obj.sparseThresholdCheck = obj.sparseThresholdCheck + uint64(numGates);            
            if obj.shouldUpdateSparsity()
                obj = obj.updateSparsity();
            end
        end
        function obj = increaseCTRLGateCount(obj,numGates) %#codegen
            % increases the number of gates
            obj.numberOfControlGates = obj.numberOfControlGates + uint64(numGates);
            obj.sparseThresholdCheck = obj.sparseThresholdCheck + uint64(numGates);            
            if obj.shouldUpdateSparsity()
                obj = obj.updateSparsity();
            end
        end
        function obj = increaseCNotGateCount(obj,numGates) %#codegen
            % increases the number of gates
            obj.numberOfCnotGatesApplied = obj.numberOfCnotGatesApplied + uint64(numGates);
            obj.sparseThresholdCheck = obj.sparseThresholdCheck + uint64(numGates);            
            if obj.shouldUpdateSparsity()
                obj = obj.updateSparsity();
            end
        end
        
        function obj = increaseSwapGateCount(obj,numGates) %codegen
            % increases the number of gates
            obj.numberOfSwapGates = obj.numberOfSwapGates + uint64(numGates);
            obj.sparseThresholdCheck = obj.sparseThresholdCheck + uint64(numGates);            
            if obj.shouldUpdateSparsity()
                obj = obj.updateSparsity();
            end            
        end
        
        function sparseOrFullState = getSparseOrFullState(obj) %#codegen
        %getSparseOrFullState - Returns sparse state if available full state otherwise
        %
            if obj.isSparse
                sparseOrFullState = obj.sparseQuantumState;
                return;
            end
            sparseOrFullState = obj.quantumState; 
        end
        
        function obj = setLexicographicState(obj,state)
            % updates the state given a lexicographic state
                % Todo: check input dim factor of two
                %TODO get rid of repeaded code
                dims = size(state);
                [hdim, index] = max(dims);
                inputVec = (1.0+0.0*1i).* state;
                if index == 2
                    stateVec = transpose(inputVec)/norm(transpose(inputVec));
                else
                    stateVec = inputVec/norm(inputVec);
                end
                
                if nnz(stateVec) / (1.0*obj.hilbertSpaceDimension) < 0.7
                    obj.sparseQuantumState = sparse(stateVec);
                    obj.hilbertSpaceDimension = uint64(hdim);
                    obj.numberOfQubits = uint32(log2(hdim));
                    obj.isSparse = true;
                    % dummy quantum state for codegen compatibility
                    localVar = 1i*ones(obj.numberOfQubits,int32(1));
                    coder.varsize('localVar',[inf 1]);

                    % we keep the  quantum state first dim variable as we may
                    % not need to allocate the full state.
                    obj.quantumState = localVar;                
                else
                    obj.quantumState = stateVec;
                    obj.hilbertSpaceDimension = uint64(hdim);
                    obj.numberOfQubits = uint32(log2(hdim));
                    obj.isSparse = false;
                    % zero state for the sparse state
                    obj.sparseQuantumState = sparse(1,1,0+0.0*1i,2^obj.numberOfQubits,1);                    
                end            
        end
        
    end
    
    

end

