stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 2];
%stimVector = [1 1 1 2];
len = length(stimVector);
mmnVector = zeros(1,len);
failurePenalty = 1; %This tells us the rate at which failure decreases the weights of the pattern predictions




pivot = 2;

%these are the indices in the pattern matrix that have patterns that could
%still potentially match the previous patterns. If they can't, they are set
%to -1
patterns = [];
totalPatterns = 0; %This is the total number of patterns we've seen, including repeats
currentPattern = [];
patternIndex = 1; %This is how far along we are in a pattern
matchingIndices = [1:length(patterns)];
for n = 1:len
    surprise = 0;
    curStim = stimVector(n);
    currentPattern = [currentPattern curStim];
    for(i = 1:length(matchingIndices))
        index = matchingIndices(i);
        if (index ~= -1)
            prevPattern = patterns(index).pattern;
            if patternIndex > length(prevPattern) || curStim ~= prevPattern(patternIndex) %if this pattern is rejected
                surprise = surprise + patterns(index).weight;
                matchingIndices(i) = -1;
                patterns(index).weight = patterns(index).weight - failurePenalty; % we penalize the pattern for failing.
                if(patterns(index).weight < 0) 
                    patterns(index).weight = 0;
                end
            end
        end
    end
    if(curStim ~= pivot)
        patternIndex = patternIndex +1;
    else if(curStim == pivot) %%if we're at the end of the current pattern, we're going to see if we have a "match" or if we have to add a new pattern.
            match = false;
            for j = 1:length(matchingIndices) %now we check to see who our "winner" is, if there was one
                if matchingIndices(j) ~= -1
                    match = true;
                    surprise = surprise - patterns(j).weight;
                    patterns(j).weight = patterns(j).weight + 1; %% we reward the correct pattern
                end
            end
            if match == false %if there was no winner
                weightedPattern.pattern = currentPattern;
                weightedPattern.weight = 1; 
                patterns = [patterns weightedPattern]
            end
        totalPatterns = totalPatterns + 1;
        matchingIndices = [1:length(patterns)];
        currentPattern = [];
        patternIndex = 1;
        end

        
    end
    mmnVector(n) = surprise
end

subplot(2,1,1)
lplot(stimVector);
set(gca,'XTick',[1:len]);
subplot(2,1,2)
lplot(mmnVector);
set(gca,'XTick',[1:len]);

