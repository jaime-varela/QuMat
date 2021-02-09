function newState = createHadamardState(n) %#codegen
qc = qregister(n);
gateArray = standardGates.H;

for qubitNum = 1:n
    gateArray(:,:,qubitNum) = standardGates.H;    
end
qc = singleQubitGateArray(qc,gateArray);


newState = qc.getState();
end

