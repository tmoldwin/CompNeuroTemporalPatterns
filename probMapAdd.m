%%This function updates the frequency of a particular item in the probMap
%%by adding 1 to the value for that item if the item is in the probability
%%map. If the item is not already in the map, the item is added as a key
%%and its value is set to one.
function probMapAdd(probMap, key)
    if(probMap.keySet().contains(key)) %if we already have a value
            value = probMap.get(key);
            value = value + 1;
            probMap.put(key, value);
        else
            probMap.put(key,1);
    end 
end