classdef multiGateUtil
    %MULTIGATEUTIL A multi gate utility
    %   use this to construct multi-gate operators
    
    methods (Static)
        
        function controlQp = constructControlOperator(numQubits,controlQubit,targetQubit,gate)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            % see formula 1.36 of the Mermin book
            firstQubit = controlQubit;
            secondQubit = targetQubit;
            if controlQubit > targetQubit
                firstQubit = targetQubit;
                secondQubit = controlQubit;
            end
            
            
            numRemainingQubits = numQubits-1- secondQubit;
            dimRemainingQubits = uint64(2)^uint64(numRemainingQubits);
            dimStartQubits = uint64(2)^(uint64(firstQubit));
            dimMidQubits = uint64(2)^uint64(secondQubit - firstQubit -1);
            numAfterFirst = numQubits -1 - firstQubit;
            dimAfterFirst = uint64(2)^uint64(numAfterFirst);
            
            ntilde = sparse(standardGates.ProjectZero);
            n = sparse(standardGates.ProjectOne);
            startIden = speye(dimStartQubits);
            midIden = speye(dimMidQubits);
            endIden = speye(dimRemainingQubits);
            if controlQubit < targetQubit
                controlQp = kron(startIden,kron(ntilde,speye(dimAfterFirst))) + ...
                    kron(startIden,  kron( kron(n , midIden) ,kron(sparse(gate),endIden) ) );
            else
                controlQp =  kron(kron(startIden , speye(2)) , kron(kron(midIden, ntilde) , endIden)) + ...
                    kron(kron(startIden , sparse(gate)) , kron(kron(midIden, n), endIden));
            end
        end
    end
end

