function [state1 , state2, state3] = initialize_t(n)

qc = qregister(n);
state1 = qc.getState();

qc2 = qregister(n,3);
state2 = qc2.getState();

qc3 = qregister(1,1,0,1);
state3 = qc3.getState();


end

