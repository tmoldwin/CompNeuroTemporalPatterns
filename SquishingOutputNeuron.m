function [out1] = divisiveOutputNeuron(currentTimeStep, outputVector, stdRsp, error, minError, patternSize)
    if error < minError
        error = minError;
    end
    if currentTimeStep > patternSize 
    prev = outputVector(currentTimeStep - patternSize + 1:currentTimeStep - 1);
    average = mean(prev);
    dif = stdRsp - average;
    out1 = dif*error + average;
    else out1 = stdRsp;
    end
end

% function [out1] = divisiveOutputNeuron(currentTimeStep, outputVector, stdRsp, error, minError, patternSize)
%     if error < minError
%         error = minError;
%     end
%     if currentTimeStep > patternSize 
%     prev = outputVector(currentTimeStep - 1);
%     dif = stdRsp - prev;
%     out1 = dif*error + prev;
%     else out1 = stdRsp;
%     end
% end