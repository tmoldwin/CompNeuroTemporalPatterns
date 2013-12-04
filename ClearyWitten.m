stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 2];
len = length(stimVector);
mmnVector = zeros(1,len);
maxPatternSize = 5; %note that maxPatternSize(1) is the value itself, maxPatternSize (2) includes the one that preceded it and so forth.
start = 1;
orderTables = java.util.HashMap; %this stores the probability tables for each order
penalty = 2; %every time we move down an order, we divide you by two.
for i = 1:maxPatternSize %initialize the list of tables
    table = java.util.HashMap;
    orderTables.put(i,table);
end
for i = start:len
    points = 0;
    val = stimVector(i);
    %%Check the tables to see if we have a match for the preceding values.
    %%We'll start with the largest table an work our way down to 0.
    j = maxPatternSize;
    if i < j
        j = i;
    end
    while points == 0 && j  >= 1
        
        pattern = stimVector((i-j)+1:i);
        patternStr = num2str(pattern);

        Table = orderTables.get(j);

        if Table.keySet().contains(patternStr);
            points = Table.get(patternStr);
            conditionCount = 0;
            if(j > 1) %% we only count up the conditions if j > 1, if j = 1, the condition is always epsilon (we're only looking at individual letters).
                iter = Table.keySet().iterator();
                while iter.hasNext()
                    key = iter.next();
                    keyVal = str2num(key);
                    if(isequal(keyVal(1:j-1), pattern(1, j-1))) %if the first values match
                        conditionCount = conditionCount + 1;
                    end
                end
            else conditionCount = Table.keySet().size();
            end
            probability = points/conditionCount;
        end
        j = j - 1;
        j

    end

    %% update all the orders
    j = maxPatternSize;
    if i < j
        j = i;
    end
    while(j >= 1)
        pattern = stimVector((i-j)+1:i);
        patternStr = num2str(pattern);
        Table = orderTables.get(j);
        temp = 1;
        Table;
        if Table.keySet().contains(patternStr)
            temp = temp + Table.get(patternStr);
        end
        Table.put(patternStr, temp);
        j = j - 1;
    end
end
