% digraph G{
% 		a -> b[label="0.2", penwidth="0.2"];
% 		a -> c[label="0.4",weight="0.4"];
% 		c -> b[label="0.6",weight="0.6"];
% 		c -> e[label="0.6",weight="0.6"];
% 		e -> e[label="0.1",weight="0.1"];
% 		e -> b[label="0.7",weight="0.7"];
% 	}




function [] = gvPrint(timeStep, currState, nextState, observationCnt)

timeStepString = num2str(timeStep);
if timeStep < 10
    timeStepString = strcat('0',timeStepString);
string = strCat('digraph G', timeStepString, '{');
for i = 1:length(nextState(:,1))
    for j = 1:length(nextState(1,:))
        string = strvcat(string, strcat(num2str(i), ' ->  ', num2str(nextState(i,j)), '[label = "', num2str(j), ',',num2str(round(observationCnt(i,j)*100)/100), '", penwidth="', num2str(observationCnt(i,j) + 0.3), '"];'  ));
    end
end
string = strvcat(string, strcat(num2str(currState), '  [style = "filled" , fillcolor = "Yellow"];'));
string = strvcat(string, '}');
fileName = strCat('digraph G', num2str(timeStep), '.gv');
fid = fopen(fileName,'w');            %# Open the file
if fid ~= -1
   dlmwrite(fileName, string, '-append', 'newline', 'pc', 'delimiter','');      %# Print the string
    fclose('all');                     %# Close the file
end
end
