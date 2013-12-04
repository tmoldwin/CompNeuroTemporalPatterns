
%stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 ];
%stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 2];
%stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 ]
%stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 2 1 1 2 7 8 7 8 7 8 8 7 8 8 7 8 8 7 8 7 8 7 8 1 1 2 1 1 2 1 1 2 1 1 2 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 2 3 2 3 2 3 2 3 7 3 7 3 7 3 7 3 7 3 7 3 7 3 7 1 1 1 2 1 1 1 2];
%stimVector = [1 1 2 2 1 2 2 2 1 1 2 1 2 1 2 1 1 1 2 1 1 1 1 1 2 2 2 2 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2]
%stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 2 1 1 2 1 1 2 1 1 2 ];
%stimVector = [1  1  1  2  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  2  1  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  2  1  1  1  2  1  1  1  2  1  1  1  1  1  2  1  1  1  2  1  1  1  1  2]
stimVector = [4  5  6  4  5  6  4  5  6  1  2  3  1  2  5  4  5  6  1  2  3  1  2  3  4  5  6  4  5  6  1  2  3  1  2  3  1  2  3  5  1  2  3  1  2  3  1  2  3  4  5  6  1  2  3  1  2  3  4  5  6  1  2  5  1  2  3  1  2  3  4  5  6  1  2  3  4  5  6 ];
observationCnt = []; % number of observations of input D when in state S
mmn = zeros(1, length(stimVector));
maxStates = 900;
uniqueStims = []; %the unique stimuli that we've seen. the first index is the stimulus, the second is the state number of the first appearance of that stimulus
nextState = [];
numStates = 0; %largest state number used so far
state = 0; % number of current state
minCnt1 = 2; %minimum number of transitions from the current state to state S before S is eligible for cloning
minCnt2 = 2; % minimum number of visits to a state S other than the current state before S is eligible for cloning

for i = 1:length(stimVector)
    stim = stimVector(i); %read one input
    if(numStates == 0 || ~isMember(stim, uniqueStims(:,1)) ) %if we've never seen the stimulus before
        numStates = numStates + 1; % make a new state;
        newRow = [stim, numStates]; %make a new row for uniqueStims, where the state corresponding to the new stimulus is the state we just created
        uniqueStims = [uniqueStims; newRow];  % add the row to uniqueStims
        for j = 1:numStates %the first time we see a stimulus, all of the states will be assumed to have a transition on that stimulus to the state we just created
            nextState(j, stim) = numStates;
            observationCnt(j, stim) = 0; %%the number of observations of that stimulus gext updated to 0;
        end
        for j = 1:length(uniqueStims(:,1)) %we assume that after a new stimulus, if we see an old stimulus we'll transition back to the first time we saw it
            nextState(numStates, uniqueStims(j,1)) = uniqueStims(j,2);
            observationCnt(numStates, uniqueStims(j,1)) = 0;
        end
    end

    if i~=1 %if this isn't the first stimulus
        next = nextState(state, stim) %get the next state
        observationCnt(state, stim) = observationCnt(state, stim) + 1; %observations of B in state S are increased by 1
        %the next state is the one we reach from the current state once we're given the current stimulus.
        %transitionsToNext(state, stim) =  transitionsToNext(state, stim) + 1;
        nextCnt = 1; %this is a counter for all of the transitions going into the next state. We start with 1 because there will be one more going into the state than coming out
        for j = 1:length(uniqueStims(:,1))
            nextCnt = nextCnt + observationCnt(next, uniqueStims(j,1));
            %the number of times we've hit the "nxt" state is equal to the sum of all the counts adding up to this case.
            %Important note: we can use the observations of the outgoing
            %transitions to  represent the number of incoming transitions
            %because the transitions follow Kirchoff's Laws, namely the number
            %of transitions into a particular node is equal to the number of
            %transitions out of it!
        end


        oc = observationCnt(state, stim);
        numerator = oc - 1; % We're subtracting 1 because we're not counting the one we just saw for our error. This is cheating a bit, because we do count it for the denominator...
        denominator = nextCnt;

        probability = numerator/denominator; %We subtract 1 from the observation count because we don't want to include the value we just saw in the probability
        surprise = 1 - probability;

        mmn(i) = surprise;



        if((numStates < maxStates)&& observationCnt(state, stim) > minCnt1 && nextCnt-observationCnt(next, stim) > minCnt2) %if the transitions to next from the current state are greater than min1 and the transitions from everything else are greater than min2
            %begin cloning procedure
            numStates = numStates + 1;
            new = numStates; %new is the state we've just created
            nextState(state, stim) = new;
            ratio = observationCnt(state, stim) / nextCnt; % this is the ratio of transition from the current node to the next node relative to the transitions from all previous nodes to the next node
            for(j = 1: length(uniqueStims(:,1)))
                stim = uniqueStims(j,1);
                nextState(new, stim) = nextState(next, stim);
                observationCnt(new, stim) = ratio * observationCnt(next, stim); %The observations of any given stimulus in the new state is equal to the observations out of the old next state * the ratio.
                observationCnt(next, stim) = observationCnt(next, stim) - observationCnt(new, stim);
            end
            next = new;

        end
    else %if this is the first stimulus we've seen
        mmn(i) = 1;
        next = 1;
    end
    % Here we can print the model in the current timestep (don't use 1) in
    % a format usable with graphviz
    if i > 1
        gvPrint(i, state, nextState, observationCnt)
    end
    state = next;
end

figure(2);

subplot(2,1,1)
lplot(stimVector)
title('Stimulus');
set(gca,'ylim',[0 10]);
set(gca,'XTick',(1:length(stimVector)+1));

subplot(2,1,2)
lplot(mmn)
set(gca,'ylim',[0 2]);
title('Surprise');
set(gca,'XTick',(1:length(mmn)+1));

