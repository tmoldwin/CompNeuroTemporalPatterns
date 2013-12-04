stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 2];
maxPatternSize = 4;
valueToPredictions = java.util.HashMap;

for i = 1:length(stimVector) % for each stimulus in the vector/at each time step
    prob = 0; 
for n = 1:maxPatternSize
    val = stimVector(i);
    if(i-n >= 1)
           prev = stimVector(i-n);
           if(~valueToPrediction.contains(prev))
               timeSteps = zeros(1, maxPatternSize); %this will be an array of hashmaps
               for j = 1:maxPatternSize
                   timeSteps(j) = java.util.HashMap;
               end
               valueToPredictions.put(prev, timeSteps);
           end
           timeSteps = valueToPredictions.get(prev);
           current = timeSteps(n).get(val);
           if current ~= null
               timeSteps(n).put(val, current + 1);
           else timeSteps(n).put(val, 1)
           end
    end
end
end

