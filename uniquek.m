
%% Finds all unique patterns of length k in V. E.g. uniquek([1 2 3 4 1 2], 2)
%% will return [[1 2] [2 3] [3 4] [4 1]]
function patterns = uniquek(V, k)
    patterns = java.util.ArrayList;
    for n = 1:length(V) - k + 1
        curr = V(n:n+k-1);
        currstr = num2str(curr);
        if ~patterns.contains(currstr)
            patterns.add(currstr);
        end
    end
    patterns = patterns.toArray();
end