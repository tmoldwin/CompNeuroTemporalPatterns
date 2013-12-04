%This is a super simple prediction function that calculates the probability
%of the next value based on the frequency of the previous values.
% function [out1] = superSimplePrediction(stimulusVector)
%      probMap = java.util.HashMap;
%      len = length(stimulusVector);
%      
%      for n = 1:len
%          value = stimulusVector(n);
%          if probMap.keySet().contains(value)
%              j = probMap.get(value);
%              probMap.put(value, j+1/len);
%          else 
%              probMap.put(value, 1/len);
%          end
%      end
%      
%      out1 = probMap;
% end