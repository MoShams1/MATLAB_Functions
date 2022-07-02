function h = plotSE2(A,SE,C,M)
% USE IT WHEN "MEAN" AND "STANDARD ERROR" HAVE BEEN ALREADY KNOWN
% plotSE(A,SE,C,M)
% A: a vector of the averages
% SE: a vector of standard errors
% C: color
% M: marker

n = length(A); % number of points
w = 1; % Line Width

if M
    h = plot(nanmean(A,1),'color',C,'linewidth',w,'marker','o','markerfacecolor',C);
else
    h = plot(nanmean(A,1),'color',C,'linewidth',w);
end
        
up = A + SE;
dn = A - SE;
hold on
fill([1:length(up) length(up):-1:1],[up,fliplr(dn)],C,'facealpha',.5,'edgecolor','none')

xlim([0 n+1])
