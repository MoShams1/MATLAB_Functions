% erbarploter 1.0
% 13/02/2019
% Mohammad Shams
% m.shamsahmar@gmail.com
% ---------------------------------------------
% erbarploter(A,C)
% INPUTS--------
% A: matrix
% C: color

function h = erbarploter(A,color)

if ~iscell(A)
    
    h = plot(1:size(A,2),nanmean(A,1),'color',color);
    hold on
    
    up = nanmean(A,1) + (nanstd(A,0,1) ./ (size(A,1).^.5));
    dn = nanmean(A,1) - (nanstd(A,0,1) ./ (size(A,1).^.5));
    
    for it = 1:size(A,2)
        line([it it],[dn(it) up(it)],'color',color)
    end
    
else
    
    mA = cellfun(@nanmean, A);
    sA = cellfun(@nanstd, A);
    
    n = length(A);
    
    h = plot(1:length(mA),mA,'color',color);
    hold on
    
    up = mA + sA ./ (n.^.5);
    dn = mA - sA ./ (n.^.5);
    
    for it = 1:n
        line([it it],[dn(it) up(it)],'color',color)
    end
    
end

xlim([0 n+1])