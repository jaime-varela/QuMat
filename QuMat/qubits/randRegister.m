function randRegister = randRegister(numQubits)
%RANDREGISTER generate a random register
%   Return an numQubits random register
% 
%   Syntax: randomRegister = randRegister(numQubits)
%      return a register with a random state containing numQubits

%TODO: typechecks

randComplexArray = rand(2^numQubits,1) + 1i*rand(2^numQubits,1);
randRegister = qregister(randComplexArray);
end

