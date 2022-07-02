
% convert the nrec output to the saccade detection function input (findsactime.m)
% 12/08/2019
% Mohammad Shams (m.shamsahmar@gmail.com)

function [x,y] = nrec2findsactime(EyeX,EyeY)

for itrial = 1:size(EyeX,2)
    
    temp = EyeX(:,itrial);
    temp(isnan(temp)) = [];
    x{itrial,1} = temp;
    
    temp = EyeY(:,itrial);
    temp(isnan(temp)) = [];
    y{itrial,1} = temp;
    
end