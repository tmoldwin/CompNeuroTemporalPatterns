%%The output neuron normalizes the response by mutliplying the error times
%%the standard response. If the error is less than the minVal, we set it to
%%the minError, because we don't want to completely neutralize the
%%response.

function [out1] = outputNeuron(standardResponse, error, minError)
    if error < minError
        error = minError;
    end
    out1=standardResponse*error;    
end