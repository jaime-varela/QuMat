function testResultChecker(tRes)
%TESTRESULTCHECKER Summary of this function goes here
%   Detailed explanation goes here
failBit = tRes.Failed;
if failBit
    error(['test ' tRes.Name ' failed']);
end
end

