%%This is a neuron that simply maps an input to a response without any
%%adaptation. 

function [out1] = inputNeuron(currentStimulus)
    Constant = 1; %This is just some constant multiplied by the stimulus to get an output. Really, this will probably be a function (tuning curve).
    out1 = Constant * currentStimulus;
end
    