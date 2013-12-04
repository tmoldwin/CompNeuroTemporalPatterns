function [string] = prettyPrint(numStates, nextState, observedCount, uniqueStims)
string = '#states';
for n = 1:numStates
   string = strvcat(string, num2str(['s' num2str(n)]))
end
string = strvcat(string, '#initial')
string = strvcat(string, 's1')
string = strvcat(string, '#accepting')
string = strvcat(string, '#alphabet')
string = strvcat(string, num2str(uniqueStims(:,1)))
string = strvcat(string, '#transitions')
for i = 1:length(nextState(:,1))
    for j = 1:length(nextState(1,:))
        if(~observedCount(i,j) == 0)
        string = strvcat(string, strcat('s', num2str(i), ':', num2str(j), '>', 's', num2str(nextState(i,j))))
        end
    end
end
end