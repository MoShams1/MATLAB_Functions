% ploter 1.0
% 05/04/2018
% Mohammad Shams
% m.shamsahmar@gmail.com
% ---------------------------------------------
% ploter(x,A,C,S)
% INPUTS--------
% A: matrix (repetition x time)
% C: color
% S: smooth/regression window
% OUTPUTS-------
% h: plot handle

function h = ploter(x,A,C,S)

% n = size(A,2);  % number of points
w = 1.5;        % Line Width

for i = 1:size(A,1)
    A(i,:) = smooth(A(i,:),S,'lowess');
end

hh = plot(x,nanmean(A,1),'color',C,'linewidth',w);

if nargout == 1
    h = hh;
end

for j = 1:size(A,2)
    notnan(1,j) = sum(~isnan(A(:,j)));
end

if size(A,1)>1
    
    up = nanmean(A,1) + (nanstd(A,[],1) ./ (notnan.^.5));
    dn = nanmean(A,1) - (nanstd(A,[],1) ./ (notnan.^.5));
    
    hold on
    if sum(isnan(up))==0 && sum(isnan(up))==0 % if there was no NaN in "up" and "dn"
        fill([x fliplr(x)],[up,fliplr(dn)],C,'edgecolor','none','facealpha',.5)
    else
        plot(up,'color',C)
        plot(dn,'color',C)
    end
        
end


% xlim([0 length(x)+1])
% set(gca,'xtick',1:length(x))

