%%This is a simple least squares model, where the output depends on the
%%relationship between every stimulus and the three that preceded it. 

%stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 2];
stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2];
len = length(stimVector);
resVector = zeros(1,len);
patternSize = 4;
conditionSize = patternSize-1; 

for n = 1: len %loop through each time step
    if(n>=patternSize)
    currentStim = stimVector(n);
    currentPattern = stimVector(n-conditionSize:n-1);
    previousStimuli = stimVector(1:n-1);
    leastSquareResult = leastSquares(previousStimuli,4, 99);
    resVector(n) = currentPattern * leastSquareResult;
    else
        resVector(n) = stimVector(n);
    end
end


subplot(3,1,1);
plot(1:len, stimVector);
set(gca,'ylim',[0 3]);
set(gca,'XTick',[1:len]);
title('Stimulus');
xlabel('Stimulus Time');
ylabel('Response');

subplot(3,1,2);
plot(1:len, resVector);
set(gca,'ylim',[0 3]);
set(gca,'XTick',[1:len]);
title('LeastSquare Prediction')
xlabel('Stimulus Time');
ylabel('Prediction');
