function randomQubitRegister = randKet()
%RANDKET Summary of this function goes here
%   Detailed explanation goes here

randVec = [(rand() + 1i*rand()); (rand() +1i*rand())];
randomQubitRegister = qregister(randVec);

end

