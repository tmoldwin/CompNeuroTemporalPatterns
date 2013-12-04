%%This is a model of a neural network that suppresses the output of a
%%neuron based on a predictive model. There are four components to this
%%network. The first component is the front end, which maps a stimulus to
%%its standard response. As of now, the front end is simply a
%%multiplicative constant  (currently 1) multiplied by the stimulus. There
%%is a probability prediction module, which predicts what the next stimulus
%%will be based on the previous stimuli. The prediction is a map of outcomes 
%%(the predicted next stimulus) to their probabilities. This module should be swappable
%%with other modules, depending on how we want to model the pattern
%%prediction. There is an "error detector" neuron which evaluates the
%%difference between the predicted next stimulus and the actual next
%%stimulus. Finally, there is an "output" neuron that mulitplies the
%%standard response from the linear front end by the error to acheive the
%%suppressed response. 



%stimVector = [1 1 2 1 1 2 1 1 2 1 1 2 1 1 2 1 1 2 1 1 1 2 1 2 1 1 2]
%stimVector = [1 2 1 2 1 2 1 2 1 2 1 2 1 1 2 1 2 1 2 1 2 1 2 1 1 1];
stimVector = [1 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 1 2]
%stimVector = [1  1  1  2  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  2  1  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  1  2  1  1  1  2  1  1  1  1 2 1  1  1  2  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  2  1  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  1  2  1  1  1  2  1  1  1  1 2]
%stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2];
len = length(stimVector);
standardResponseVector = zeros(1,len); %stores the standard response at each time step
errorDetectorVector = zeros(1,len); %stores the prediction error at each time step
outputVector = zeros(1,len); %stores the output at each time step
for n = 1: len %loop through each time step
    currentStim = stimVector(n);
    stdResponse = linearFrontEnd(currentStim);
    standardResponseVector(n) = stdResponse;
    previousStimuli = stimVector(1:n-1);
    probMap = patternPredictor(previousStimuli, 4, 30, 2); %We're looking at a timestep of size 4, a max lookback distance of 30, and a minimum of 1 repetition of the pattern. 
    error = errorDetectorNeuron(currentStim, probMap);
    errorDetectorVector(n) = error;
    output = outputNeuron(stdResponse, error, 0); %Minimum error is 0.5
    %output = squishingOutputNeuron(n, outputVector, stdResponse, error, 0, 4);
    outputVector(n) = output;
end

s1 = subplot(3,1,1);
%plot(1:len, standardResponseVector, '-o');
lplot(standardResponseVector);
set(gca,'ylim',[0 3]);
set(gca,'XTick',[1:len]);
title('Linear Response (=Stimulus)');
xlabel('Stimulus Time');
ylabel('Response');

subplot(3,1,2);
lplot( errorDetectorVector);
set(gca,'ylim',[0 2]);
set(gca,'XTick',[1:len]);
title('Error')
xlabel('Stimulus Time');
ylabel('Error');

subplot(3,1,3);
lplot(outputVector);
set(gca,'ylim',[0 3]);
set(gca,'XTick',[1:len]);
title('Normalized Output');
xlabel('Stimulus Time');
ylabel('Response');