% used for scratch work


% qc = qregister(3);
% state = qc.getState();
% 
% % qc = hGate(qc,0);
% % qc = hGate(qc,1);
% % qc = hGate(qc,2);
% 
% qc = singleQubitGateArray();
% 
% newState = qc.getState();


% functions to use bitget!
% To implement destructive measurement you can use
% https://www.mathworks.com/help/matlab/ref/nonzeros.html
% note that because we already have a lexicographic ordering
% this may limit the ability to do non-computational basis measurements
% (most likely we'd have to figure out the gate that needs to be applied
% and apply the gate and then the computational basis measurement)



myHadamard = createHadamardState(int32(4))