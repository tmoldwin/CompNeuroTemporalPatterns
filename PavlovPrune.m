function out1 = PavlovPrune(dictionary, sequence, threshhold)
dictionary = sortByLength(dictionary);
iter = dictionary.listIterator();
while(iter.hasNext())
    word = iter.next();
    containingWords = java.util.ArrayList();
    for j = 0:dictionary.size()-1
        word2 = dictionary.get(j);
        if length(num2str(word2)) > length(num2str(word)) && ~isempty(strfind(word2, word)) %%if word2 is longer than word1 and word1 is within word 2
            containingWords.add(word2);
        end
    end
    wordct = length(strfind(sequence, str2num(word)));
    word2sum = 0;
    iter2 = containingWords.listIterator();
    while(iter2.hasNext())
        word2 = iter2.next();
        word2ct = length(strfind(sequence, str2num(word2)));
        word2sum = word2sum + word2ct * length(strfind(str2num(word2), str2num(word))); %%we multiply the word2ct by the number of times word appears in word2 because one word2 can explain multiple words).
    end
%     word2sum
%     wordct
    if word2sum/wordct >= threshhold
        iter.remove();
    end
end
out1 = dictionary;
end

