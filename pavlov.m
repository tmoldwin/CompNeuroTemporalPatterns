%%This model builds a dictionary of patterns by finding pivot points which
%%are instrumental in creating predictions. Those predictions are used to
%%create more predictions, and so forth.

% Dictionary = [each unique stimulus in recent memory]
% for each word in the dictionary
%     while exists next such that prediction(next|word) > threshhold
%         word = word + next
%     end
% end
maxinitialsize = 2;

stimVector = [2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1  1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1];
%sequence with two patterns
stimVector = [];
for n = 1:300
    randy = rand;
    if rand <=0.5
        stimVector = [stimVector [1 2 3]];
    else
        stimVector = [stimVector [1 4 5]];
    end
end
%end of sequence
% %stimVector = [1 2 3 1 2 3 1 2 3 1 2 3 1 2 3];
% %stimVector = [ 1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3 1 1 2 2 3 3];
%stimVector = [1 2 3 1 4 5 1 4 5 1 2 3 1 2 3 1 4 5 1 4 5 1 2 3 1 4 5 1 4 5];
% stimVector = [1 2 1 2 1 2 1 2 1 2];
%stimVector = [1 2 3 1 2 3 2 3 2 3];
stimVector = [1 1 2 3 1 1 2 3 1 1 2 3 1 1 2 3 1 1 2 3 1 1 2 3];
for k = 1:maxinitialsize
    dictionary = java.util.ArrayList; %we start off by looking at the unique stimuli in the sequence
    uniques = ((uniquek(stimVector,k)));
    for n = 1:size(uniques,1)
        dictionary.add(uniques(n));
    end
    threshhold = 0.7;
    for i = 0:dictionary.size()-1
        currentPattern = str2num(dictionary.get(i));
        change = true; %we keep track of whether or not we've increased the size of the prediction
        while(change == true)
            followers = java.util.HashMap;
            currPatternSize = length(currentPattern);
            for j = 1:length(stimVector)-currPatternSize
                currPatternSize = length(currentPattern);
                stimPattern = stimVector(j:j+currPatternSize - 1);
                if  stimPattern == currentPattern %if we've found an instance of the pattern
                    nextStim = stimVector(j+currPatternSize);
                    probMapAdd(followers, nextStim);
                end
            end
            %%normalize the HashMap
            probMapNormalize(followers);
            iter = followers.keySet().iterator();
            change = false;
            while iter.hasNext()
                key = iter.next();
                %%if the transitional probability from the past pattern to
                %%the next tone is sufficiently high and the next tone
                %%isn't also a pivot
                if followers.get(key) > threshhold && key ~= currentPattern(1)
                    currentPattern = [currentPattern key];
                    dictionary.set(i, num2str(currentPattern));
                    change = true;
                end
            end
        end
    end

    dictionary
    dictionary = PavlovPrune(dictionary, stimVector, 0.9)
end

