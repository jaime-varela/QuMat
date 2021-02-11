% A function to run a test

% add QuMat to path
addpath(genpath('QuMat'));
runCodegenTests = false;

% run all tests
testRes = runtests('./tests/qregister/','IncludeSubfolders',true);
testResultChecker(testRes);
testRes = runtests('./tests/singleQubitGates/','IncludeSubfolders',true);
testResultChecker(testRes);
testRes = runtests('./tests/multiQubitGates/','IncludeSubfolders',true);
testResultChecker(testRes);


if runCodegenTests
    runtests('./tests/codegen/','IncludeSubfolders',true);
    testResultChecker(testRes);    
end