% horzerbarploter 1.0
% 13/02/2019
% Mohammad Shams
% m.shamsahmar@gmail.com
% ---------------------------------------------
% horzerbarploter(A,C)
% INPUTS--------
% A: matrix (time x repetition)
% C: color

function h = horzerbarploter(A,color)

if ~iscell(A)
    h = plot(nanmean(A,2),1:size(A,1),'color',color);
    hold on
    
    up = nanmean(A,2) + (nanstd(A,0,2) ./ (size(A,2).^.5));
    dn = nanmean(A,2) - (nanstd(A,0,2) ./ (size(A,2).^.5));
    
    for it = 1:size(A,1)
        line([dn(it) up(it)],[it it],'color',color)
    end
    
else    
    mA = cellfun(@nanmean, A);
    sA = cellfun(@nanstd, A);
    
    n = length(A);
    
    h = plot(mA,1:length(mA),'color',color);
    hold on
    
    up = mA + sA ./ (n.^.5);
    dn = mA - sA ./ (n.^.5);
    
    for it = 1:n
        line([dn(it) up(it)],[it it],'color',color)
    end
    
end

ylim([0 n+1])