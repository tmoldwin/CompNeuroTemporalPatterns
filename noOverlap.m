%stimVector = [1  1  1  2  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  2  1  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  1  2  1  1  1  2  1  1  1  1  2];
stimVector = [1 1 1 2 1 1 1 2 ]
supriseVector = zeros(1, length(stimVector));
maxPatternSize = 4;
patternToProb = java.util.HashMap;
lastTimeSeen = java.util.HashMap;
winningPatternSize = 0;
numTotalPatterns = zeros(1, maxPatternSize); % stores the number of total patterns of a particular patternSize e.g. if we've seen 112 three times and 11

for i = 1:length(stimVector) % for each stimulus in the vector/at each time step
for n = 1:maxPatternSize
    if(i-n+1 >= 1)
            window = stimVector(i-n+1:i)
            windowString = num2str(window);
            if patternToProb.keySet().contains(windowString)
                if lastTimeSeen.get(windowString) < i-n+1; %if we've already seen this pattern and there are no overlaps with the last time
                value = patternToProb.get(windowString);
                patternToProb.put(windowString, value + 1);
                lastTimeSeen.put(windowString, i); %the last time we saw this pattern was just now.
                else break; %if the pattern is overlapping, we ignore it.
                end
            else 
                patternToProb.put(windowString, 1);
                lastTimeSeen.put(windowString, i); %the last time we saw this pattern was just now.
            end
    end
end
end

patternToProb