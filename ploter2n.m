% plotern 1.0
% 15/11/2019
% Mohammad Shams
% m.shamsahmar@gmail.com
% ---------------------------------------------
% plots the zscored of the final curve
% ploter2n(x,A,C,S)
% INPUTS--------
% x: time-stamps
% A: matrix (repetition x time)
% C: color
% S: smooth/regression window
% OUTPUTS-------
% h: plot handle

function h = ploter2n(x,A,C,S)

% n = size(A,2);  % number of points
w = 1.5;          % Line Width

for i = 1:size(A,1)
    A(i,:) = smooth(A(i,:),S,'loess');
end

hh = plot(x,zscore(nanmean(A,1)),'color',C,'linewidth',w);

if nargout == 1
    h = hh;
end

for j = 1:size(A,2)
    notnan(1,j) = sum(~isnan(A(:,j)));
end

if size(A,1)>1    

    % According to this link, the SE should be scaled the same size as mean was scaled
    % http://www.talkstats.com/threads/when-normalizing-values-do-i-need-to-re-calculate-sem.5617/
    
    r = nanmean(A) ./ zscore(nanmean(A,1));

    up = nanmean(A,1) + (nanstd(A,1)./(notnan.^.5));
    dn = nanmean(A,1) - (nanstd(A,1)./(notnan.^.5));      
    
    up = up ./ r;
    dn = dn ./ r;

    hold on
    if sum(isnan(up))==0 && sum(isnan(up))==0 % if there was no NaN in "up" and "dn"
        fill([x fliplr(x)],[up,fliplr(dn)],C,'edgecolor','none','facealpha',.5)
    else
        plot(up,'color',C)
        plot(dn,'color',C)
    end
    
end



