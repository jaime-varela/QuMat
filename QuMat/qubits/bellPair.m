function bellRegister = bellPair(ind1,ind2)
%BELLPAIR Summary of this function goes here
%   See page 25 of Nielsen and Chuang text

% TODO verify inputs

entangledRegister = qregister(2,0);

if ind2 == 1
   entangledRegister = xGate(entangledRegister,1);
end

if ind1 == 1
    entangledRegister = xGate(entangledRegister,0);
end


entangledRegister = hGate(entangledRegister,0);
entangledRegister = cnotGate(entangledRegister,0,1);
bellRegister = entangledRegister;
end

