% A function to run a test

% add QuMat to path
addpath(genpath('QuMat'));

% run all tests
testRes = runtests('./tests/qregister/','IncludeSubfolders',true);
testResultChecker(testRes);
testRes = runtests('./tests/singleQubitGates/','IncludeSubfolders',true);
testResultChecker(testRes);

%runtests('./tests/codegen/','IncludeSubfolders',true)
%testResultChecker(testRes);


