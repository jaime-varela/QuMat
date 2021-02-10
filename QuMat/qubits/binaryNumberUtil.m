classdef binaryNumberUtil
    %BINARYNUMBERUTIL A utility to deal with binary numbers
    %   Number to bin and vice versa
    
    properties
        Property1
    end
    
    methods (Static)
        function number = binaryNumberToDecimal(varargin)
           % binaryNumber(100) -> 4
           
           %TODO: check number in correct range
           numArray = zeros(1,nargin);
           for bitVal = 1:nargin
               numArray(bitVal) = varargin{bitVal};
           end
           binStr = num2str(numArray);
           binaryString = blanks(nargin);
           binaryString(1) = binStr(1);
           counter = 1;
           dims = size(binStr);
           for charInd = 1:dims(2)
                if ~isspace(binStr(charInd))
                    binaryString(counter) = char(binStr(charInd));
                    counter = counter +1;
                end
           end
           number = bin2dec(binaryString);
        end
        
        function binArray = decimalToBinary(number)
           binArray = de2bi(number);
        end
    end
end

