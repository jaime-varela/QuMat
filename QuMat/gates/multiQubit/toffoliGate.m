function updatedRegister = toffoliGate(qregister,controlQubit, secondControlQubit,targetQubit)
%toffoliGate Toffoli gate implemented via single and two qubit gates
%   Toffoli gate

%TODO document and verify inputs
% TODO2 may not be optimal
% TODO3 see if it works with target at index 0

numQubits = qregister.numberOfQubits;

% see wikipedia diagram and its reference
%step 1 - 8
updatedRegister = qregister;
updatedRegister = hGate(updatedRegister,targetQubit);
updatedRegister = cnotGate(updatedRegister,secondControlQubit,targetQubit);
updatedRegister = singleQubitGate(updatedRegister,targetQubit,standardGates.Tdag);
updatedRegister = cnotGate(updatedRegister,controlQubit,targetQubit);
updatedRegister = tGate(updatedRegister,targetQubit);
updatedRegister = cnotGate(updatedRegister,secondControlQubit,targetQubit);
updatedRegister = singleQubitGate(updatedRegister,targetQubit,standardGates.Tdag);
updatedRegister = cnotGate(updatedRegister,controlQubit,targetQubit);
%step 9
updatedRegister = singleQubitGate(updatedRegister,secondControlQubit,standardGates.T);
updatedRegister = tGate(updatedRegister,targetQubit);
%step 10
updatedRegister = cnotGate(updatedRegister,controlQubit,secondControlQubit);
updatedRegister = hGate(updatedRegister,targetQubit);
%step 11
updatedRegister = tGate(updatedRegister,controlQubit);
updatedRegister = singleQubitGate(updatedRegister,secondControlQubit,standardGates.Tdag);
%step 12
updatedRegister = cnotGate(updatedRegister,controlQubit,secondControlQubit);

end
