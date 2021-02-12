function newState = createHadamardState_t(n)

qc = qregister(n);

for qubitNum = 0:n-1
    qc = hGate(qc,qubitNum);    
end


newState = qc.getState();
end

