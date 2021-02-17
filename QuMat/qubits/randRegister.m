function randRegister = randRegister(numQubits)
%RANDREGISTER Summary of this function goes here
%   Detailed explanation goes here
randComplexArray = rand(2^numQubits,1) + 1i*rand(2^numQubits,1);
randRegister = qregister(randComplexArray);
end

