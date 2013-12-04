function newlist = sortByLength(arraylist)
newlist = java.util.ArrayList;
while arraylist.size() > 0    
    max = [];
    for i = 0:arraylist.size()-1
        curr = arraylist.get(i);
        if length(str2num(curr)) > length(max)
            max = str2num(curr);
        end
    end
    arraylist.remove(num2str(max));
    newlist.add(num2str(max));
end
end