function [out1] = divConstant(stimVector, pivot)
% % pivot tells us the value that signifies the end of one pattern / the
% start of a new one
patternCount = 0;
prevPivotIndex = 0; 
divConstants = [];
for n = [1:length(stimVector)]
    if stimVector(n) == pivot
        patternCount = patternCount+1;
        pattern = stimVector(prevPivotIndex + 1:n-1);
        patternSum = sum(pattern);
        divConstants(patternCount) =  pivot/patternSum;
        prevPivotIndex = n;
        
    end
end
pattern = stimVector((prevPivotIndex + 1):length(stimVector));
mean1 = mean(divConstants)
out1 = pivot/(mean(divConstants)*sum(pattern));
end

