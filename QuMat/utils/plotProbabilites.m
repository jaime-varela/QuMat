function probPlot = plotProbabilites(Qregister,varargin)
%PLOTPROBABILITES Summary of this function goes here
%   Detailed explanation goes here
fullState = Qregister.getState();

probabilities = conj(fullState) .* fullState;

isLexicographPlot = false;
if nargin >= 2
    isLexicographPlot = varargin{1};
end

XStr = cell(1,Qregister.hilbertSpaceDimension);
if ~isLexicographPlot
    for intVal = 0:Qregister.hilbertSpaceDimension - 1
        XStr{intVal+1} = strcat(['|' dec2bin(intVal) '\rangle']);
    end
    X = categorical(XStr);
    X = reordercats(X,XStr);
    probPlot = bar(X,probabilities);    
else
    for intVal = 0:Qregister.hilbertSpaceDimension - 1
        XStr{intVal+1} = strcat(['|' num2str(intVal) '\rangle']);
    end
    X = categorical(XStr);
    X = reordercats(X,XStr);
    probPlot = bar(X,probabilities);    
end

ylim([0 1]);
end


