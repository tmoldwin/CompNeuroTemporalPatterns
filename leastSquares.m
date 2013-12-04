function [out1] = leastSquares(stimVector, patternSize, maxDistance)
% %patternSize is the whole pattern,
% %i.e. the new value that we're prediciting and the values before it.
% % maxDistance is the maximum number of timesteps we're willing to look
% % back to make our prediction. minReps is the number of repetitions of a
% % pattern that we need to see before it is deemed relevant.

len = length(stimVector);
conditionSize = patternSize - 1;
conditions = zeros(length(stimVector)-conditionSize, 3); %%Stores every pattern of three
results = zeros(length(stimVector)-conditionSize, 1); %%Stores every value following the pattern of three

if(len >= patternSize)
    currentPattern = stimVector(len + 1 - conditionSize:len);

    %if the stimulus vector is smaller than the patternSize, we can't calculate any probabilities
    if (len - maxDistance <= 0)
        start = 1;
    else
        start = len - maxDistance;
    end

    for n = (start:length(stimVector)-conditionSize)
        pattern = stimVector(n:n+conditionSize-1);
        nextStim = stimVector(n+conditionSize)
        conditions(n,1:3) = pattern
        results(n) = nextStim;
    end
end
out1 = conditions\results

end
