%%This neuron gives an output based on the difference between the predicted
%%stimulus (actually a probability distribution) and the actual stimulus.
function [error] = errorDetectorNeuron(currentStimulus, predictionMap)
    keys = predictionMap.keySet();
    if(keys.contains(currentStimulus)) % if we have a probability associated with the currentStimulus
        error = (1-predictionMap.get(currentStimulus)); %%the error is 1-predicted probability
    else
        error = 1; %If we've never seen it before, it was never predicted, so the probability is 1;
    end
end