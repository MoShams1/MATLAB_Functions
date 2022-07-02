% ploterr 1.0
% 21/11/2019
% Mohammad Shams
% m.shamsahmar@gmail.com
% ---------------------------------------------
% plots row normalized version of input A
% ploterrn(x,A,C,S)
% INPUTS--------
% x: time-stamps
% A: matrix (repetition x time)
% C: color
% S: smooth/regression window
% OUTPUTS-------
% h: plot handle

function h = ploterrn(x,A,C,S)

w = 1.5;          % Line Width

for i = 1:size(A,1)
    A(i,:) = smooth(A(i,:),S,'loess');
%     A(i,:) = (A(i,:)-nanmean(A(i,:))) ./ nanstd(A(i,:));
end

hh = plot(x,nanmean(A),'color',C,'linewidth',w);

if nargout == 1
    h = hh;
end

for j = 1:size(A,2)
    notnan(1,j) = sum(~isnan(A(:,j)));
end

if size(A,1)>1
   
    up = nanmean(A,1) + (nanstd(A,1)./(notnan.^.5));
    dn = nanmean(A,1) - (nanstd(A,1)./(notnan.^.5));

    hold on
    if sum(isnan(up))==0 && sum(isnan(up))==0 % if there was no NaN in "up" and "dn"
        fill([x fliplr(x)],[up,fliplr(dn)],C,'edgecolor','none','facealpha',.5)
    else
        plot(up,'color',C)
        plot(dn,'color',C)
    end
    
end