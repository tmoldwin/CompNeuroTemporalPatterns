%stimVector = [1 1 1 2 1 1 1 2 1 1 1 2 1 1 2 1 1 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1 1 2 1 1 2];
stimVector = [1 1 1 1 2 1 1 1 1 2 1 1 1 1 2 1 1 2 1 2 1 1 ]
transitionTables = java.util.HashMap; %%This is the set of transition tables. TransitionTables(i,j) is the table from i to j.
counters = java.util.HashMap; %This table maps states to their counters, e.g. counters(1) will return the value of the counter on state 1.
len = length(stimVector);
mmnVector = zeros(1,len);
for i = 1:len
    val = stimVector(i);
    if i == 1
        counters.put(val,1);
        mmnVector(i) = 1;
    else
        prev = stimVector(i-1)
        counter = counters.get(prev)
        prevVal = [prev val]; %this is a tuple, of the previous value and the current value
        table = transitionTables.get(num2str(prevVal));
        if isequal(table, []); % if we don't already have an entry
            table = java.util.HashMap; %%initialize the table
        end
        points = table.get(counter); %%current number of points for this particular transition
        if isequal(points, []);
            points = 0;
        end
        %%this is where we account for the mmn stuff.
        reps = 0; % number of times we've seen this number of repeats of prev
        iter = transitionTables.keySet().iterator();
        while iter.hasNext()
            key = iter.next();
            keyStr = str2num(key);
            if(keyStr(1) == prev )
                if ~isequal(transitionTables.get(key).get(counter), [])
                reps = reps + transitionTables.get(key).get(counter)
                end
            end
        end
        if reps == 0
            reps = 1
        end

        mmn = 1 - (points/reps);
        mmnVector(i) = mmn;

        points = points + 1;



        table.put(counter, points);


        %val
        %table
        transitionTables.put(num2str(prevVal), table);
        if(val == prev)
            counter = counter + 1;
            counters.put(val, counter);
        else if val ~= prev %%If we've switched to a new state, we set the counter on the previous state to zero
                counter = 0;
                counters.put(prev, counter);
                counters.put(val, 1);
            end
        end
    end
end

figure(1); 

subplot(3,1,1);
lplot(stimVector);
set(gca,'ylim',[0 3]);
set(gca,'XTick',[1:len]);
title('Stimulus');
xlabel('Stimulus Time');
ylabel('Response');

subplot(3,1,2);
lplot(mmnVector);
set(gca,'ylim',[0 1]);
set(gca,'XTick',[1:len]);
title('Surprise');
xlabel('Stimulus Time');
ylabel('Response');

