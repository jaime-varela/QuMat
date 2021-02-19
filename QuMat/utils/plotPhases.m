function probPlot = plotPhases(Qregister,varargin)
%PLOTPHASES Plot the phase angles for elements of the state
%   The angles are between $-\pi$ and $\pi$
%   
%   Syntax: phasePlot = plotPhases(Qregister)
%       plot the phases with qubit state labels
%
%   Syntax: phasePlot = plotPhases(Qregister,isLexicographDisplay)
%       displays lexicographic labels if isLexicographDisplay=true

%TODO: type checks

fullState = Qregister.getState();

probabilities = angle(fullState);

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

ylim([-pi pi]);
end

