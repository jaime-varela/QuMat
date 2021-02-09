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
           binStr(isspace(binStr)) = '';
           number = bin2dec(binStr);
        end
        
        function binArray = decimalToBinary(number)
           binArray = de2bi(number);
        end
    end
end

