function probPlot = plotProbabilites(Qregister,varargin)
%PLOTPROBABILITIES Plot the probability amplitudes of the state
%   The values are between 0 and 1
%   
%   Syntax: probPlot = plotProbabilites(Qregister)
%       plot the phases with qubit state labels
%
%   Syntax: probPlot = plotProbabilites(Qregister,isLexicographDisplay)
%       displays lexicographic labels if isLexicographDisplay=true

%TODO: type checks

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


