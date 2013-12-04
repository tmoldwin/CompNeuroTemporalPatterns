%%Divides each value in a probability map by the sum of all values in the
%%map to create a normalized map of values to probabilities.

function probMapNormalize(probMap)
iter = probMap.keySet().iterator;
totalValue = 0;
while iter.hasNext()
    totalValue = totalValue + probMap.get(iter.next());
end
iter = probMap.keySet().iterator;
while iter.hasNext()
    key = iter.next();
    value = probMap.get(key);
    probability = value/totalValue;
    probMap.put(key, probability);
end
end
