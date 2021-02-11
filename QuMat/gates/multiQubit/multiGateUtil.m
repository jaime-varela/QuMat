classdef multiGateUtil
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        
        function controlQp = constructControlOperator(numQubits,controlQubit,targetQubit,gate)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            % see formula 1.36 of the Mermin book
            numRemainingQubits = numQubits-1- targetQubit;
            dimRemainingQubits = uint64(2)^uint64(numRemainingQubits);
            dimStartQubits = uint64(2)^(uint64(controlQubit));
            dimMidQubits = uint64(2)^uint64(targetQubit - controlQubit -1);
            numAfterControl = numQubits -1 - controlQubit;
            dimAfterControl = uint64(2)^uint64(numAfterControl);
            
            ntilde = sparse(standardGates.ProjectZero);
            n = sparse(standardGates.ProjectOne);
            startIden = speye(dimStartQubits);
            midIden = speye(dimMidQubits);
            endIden = speye(dimRemainingQubits);
            controlQp = kron(startIden,kron(ntilde,speye(dimAfterControl))) + ...
                kron(startIden,  kron( kron(n , midIden) ,kron(sparse(gate),endIden) ) );
        end
    end
end

