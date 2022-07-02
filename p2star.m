%% p-value to star
% 20/2/2019
% Mohammad Shams
% m.shamsahmar@gmail.com

function p2star(p)

if p<0.001
    disp('***')
    
elseif p<0.01
    disp('**')
    
elseif p<0.05
    disp('*')
    
else
    disp('n.s.')
end
