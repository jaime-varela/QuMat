function randomQubitRegister = randKet()
%RANDKET Random 1-qubit register
%   Generate a random 1-qubit register
%
%   Syntax: randomQubitRegister = randKet()
%     random qubit.

%TODO typechecks

randVec = [(rand() + 1i*rand()); (rand() +1i*rand())];
randomQubitRegister = qregister(randVec);

end

