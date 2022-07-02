% plotern 1.0
% 08/08/2018
% Mohammad Shams
% m.shamsahmar@gmail.com
% ---------------------------------------------
% plots the zscored of the final curve
% plotern(A,C,S)
% INPUTS--------
% A: matrix (repetition x time)
% C: color
% S: smooth/regression window
% OUTPUTS-------
% h: plot handle

function h = plotern(A,C,S)

% n = size(A,2);  % number of points
w = 1.5;          % Line Width

for i = 1:size(A,1)
    A(i,:) = smooth(A(i,:),S,'loess');
end

hh = plot(zscore(nanmean(A,1)),'color',C,'linewidth',w);

if nargout == 1
    h = hh;
end

for j = 1:size(A,2)
    notnan(1,j) = sum(~isnan(A(:,j)));
end

if size(A,1)>1
    up = zscore( nanmean(A,1) + (nanstd(A,1)./(notnan.^.5)) );
    dn = zscore( nanmean(A,1) - (nanstd(A,1)./(notnan.^.5)) );
        
%     up = nanmean(A,1) + (nanstd(A,1) ./ (notnan.^.5) * 1.98);
%     dn = nanmean(A,1) - (nanstd(A,1) ./ (notnan.^.5) * 1.98);
    
    hold on
    fill([1:length(up) length(up):-1:1],[up,fliplr(dn)],C,'edgecolor','none','facealpha',.5)
end

