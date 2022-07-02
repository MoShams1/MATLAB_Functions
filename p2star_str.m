%% p-value to star
% 12/3/2019
% Mohammad Shams
% m.shamsahmar@gmail.com

function str = p2star_str(p)

if p<0.001
    str = '***';
    
elseif p<0.01
    str = '**';
    
elseif p<0.05
    str = '*';
    
else
    str = 'n.s.';
end
