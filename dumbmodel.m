stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 2];
patternLength = 4;
resVector = zeros(1,length(stimVector));
for(n=1:patternLength-1)
    resVector(n) = stimVector(n);
end
for (n=patternLength:length(stimVector))
        prev = stimVector((n+1-patternLength):n-1)
        sumPrev = sum(prev);
        resVector(n) = stimVector(n)/sumPrev;
end

figure(3)


subplot(2,1,1)
lplot(stimVector)
set(gca,'ylim',[0 2]);
set(gca,'XTick',(1:length(stimVector)));
title('Non-normalized Response');
xlabel('Stimulus Time');
ylabel('Response');        
subplot(2,1,2)
lplot(resVector)
set(gca,'ylim',[0 2]);
set(gca,'XTick',(1:length(stimVector)));
title('Normalized Response');
xlabel('Stimulus Time');
ylabel('Response');        