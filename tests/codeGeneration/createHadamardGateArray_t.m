function newState = createHadamardGateArray_t(n)

qc = qregister(n);
hgate = standardGates.H;
gateArray = singleGateUtil.generateGateArray(hgate,hgate,hgate);
qc = singleQubitGateArray(qc,gateArray);


newState = qc.getState();
end

