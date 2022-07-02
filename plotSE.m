function h = plotSE(A,C,E,S,M)
% plotSE(A,C,E,S,M)
% INPUTS--------
% A: matrix (repetition x time)
% C: color
% E: standard error
% S: smooth/regression window
% M: marker
% OUTPUTS-------
% h: plot handle

n = size(A,2); % number of points
w = 1.5; % Line Width

for i = 1:size(A,1)
    A(i,:) = smooth(A(i,:),S,'loess');
end

if E
    a = .5; % Alpha (Transparecy)
else
    a = 0;
end


if M
    hh = plot(nanmean(A,1),'color',C,'linewidth',w,'marker','o','markerfacecolor',C);
else
    hh = plot(nanmean(A,1),'color',C,'linewidth',w);
end
if nargout == 1
    h = hh;
end

for j = 1:size(A,2)
    notnan(1,j) = sum(~isnan(A(:,j)));
end

if size(A,1)>1
    up = nanmean(A,1) + (nanstd(A,1) ./ (notnan.^.5));
    dn = nanmean(A,1) - (nanstd(A,1) ./ (notnan.^.5));
%     up = nanmean(A,1) + (nanstd(A,1) ./ (notnan.^.5) * 1.98);
%     dn = nanmean(A,1) - (nanstd(A,1) ./ (notnan.^.5) * 1.98);
    hold on
    fill([1:length(up) length(up):-1:1],[up,fliplr(dn)],C,'facealpha',a,'edgecolor','none')
end

xlim([0 n+1])
