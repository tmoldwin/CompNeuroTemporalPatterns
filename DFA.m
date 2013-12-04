%%Simulates a DFA on a sequence of inputs and tries to match subsequnces of
%%the input sequence to the dictionary


dictionary = [[1 2 3] ; [4 5 6]];

stimVector = [1 2 3 7 4 5 6 4 5 5 4 5 7 1 2 7];
len = length(stimVector);
surprise = zeros(1,len);


n = 1;
while n <= len
    stim = stimVector(n);
    i = 1;
    reject = false;
    possiblePatterns = [1:length(dictionary(:,1))]; %initially, all words are possible
    while reject == false && i <= length(dictionary(1,:)) %go through each of the columns
        column = dictionary(:,i);
        temp = [];
        for k = 1:length(possiblePatterns)
            if dictionary(possiblePatterns(k),i) == stim
                temp = [temp possiblePatterns(k)];
            end
        end    
        possiblePatterns = temp;
        
        if length(possiblePatterns) == 0;  % if we don't see the curent stimulus
            reject = true;
            if i~= 1
                surprise(n) = i;
            end
            n = n + 1;
            %if sum(dictionary(1,:) == stim) == 0
            break;
        else
            n = n + 1;
            i = i + 1
            if n <= len
                stim = stimVector(n);
            end
        end
    end
end

lplot(surprise)

