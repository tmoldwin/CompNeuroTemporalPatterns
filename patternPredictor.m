%%PatternPredictor predicts, at a particular timestep, what the next value
%%will be by looking at the likelihood that a particular value will follow
%%the sequence of values immediately preceding it based on the frequency of
%%such a sequence in the previous stimuli. For example, let's say we have a
%%pattern size of 4, and we want to determine how likely 1 1 1 0 is going
%%to appear, as opposed to 1 1 1 1. We search the sequence for previous
%%cases where 1 1 1 appears, then we see, out of those cases, how many times
%%the next value is a 0 and how many times the next value is a 1.


function [out1] = patternPredictor(stimVector, patternSize, maxDistance, minReps) 
%%PatternSize is the whole pattern,
%%i.e. the new value that we're prediciting and the values before it.
%% maxDistance is the maximum number of timesteps we're willing to look
%% back to make our prediction. minReps is the number of repetitions of a
%% pattern that we need to see before it is deemed relevant.
probMap = java.util.HashMap;
len = length(stimVector);
conditionSize = patternSize-1;

if(len >= patternSize)
currentPattern = stimVector(len+1-conditionSize:len);
patternCounter = 0;

 %if the stimulus vector is smaller than the patternSize, we can't calculate any probabilities
if (len - maxDistance <= 0)
    start = 1;
else
    start = len - maxDistance;
end

for n = (start:length(stimVector)-conditionSize)
    pattern = stimVector(n:n+conditionSize-1);
    if(isequal(pattern, currentPattern)) %if it's a match
        nextStim = stimVector(n+conditionSize);
        if(probMap.keySet().contains(nextStim)) %if we already have a value
            value = probMap.get(nextStim);
            value = value + 1;
            probMap.put(nextStim, value);
        else
            probMap.put(nextStim,1);
        end 
        patternCounter = patternCounter + 1
    end
end
end

%%Now normalize the values in the map based on the number of times the
%%condition pattern was seen.
iter = probMap.keySet().iterator();
while iter.hasNext()
    key = iter.next();
    value = probMap.get(key);
    if value < minReps %%if the pattern wasn't repeated a sufficient number of times, we discount it.
        value = 0;
    end
    probMap.put(key, value/patternCounter);
end
out1 = probMap;

end
