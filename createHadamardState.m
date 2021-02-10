function newState = createHadamardState(n) %#codegen
qc = qregister(n);
gateArray = zeros(2,2,n);

for qubitNum = 1:n
    gateArray(:,:,qubitNum) = standardGates.H;    
end
qc = singleQubitGateArray(qc,gateArray);

newReg = qregister(1,0,1,0);

anotherReg = qregister(4,3);



newState = qc.getState();
end

