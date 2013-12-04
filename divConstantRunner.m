stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 2];
len = length(stimVector);
pivot = 2;
pivCount = 0;
resVector = zeros(1,len);

for n = 1: len %loop through each time step
    currentStim = stimVector(n);       
    if(currentStim == pivot)
        if (pivCount >= 1)
        prevStimuli = stimVector(1:n-1);
        resVector(n) = divConstant(prevStimuli, pivot);
        else resVector(n) = pivot;
        end
        pivCount = pivCount + 1;
    else resVector(n) = currentStim;
    end        
    
end

figure(2);

subplot(3,1,1);
lplot(stimVector);
set(gca,'ylim',[0 3]);
set(gca,'XTick',[1:len]);
title('Stimulus');
xlabel('Stimulus Time');
ylabel('Response');

subplot(3,1,2);
lplot(resVector);
set(gca,'ylim',[0 3]);
set(gca,'XTick',[1:len]);
title('Normalized response');
xlabel('Stimulus Time');
ylabel('Response');
