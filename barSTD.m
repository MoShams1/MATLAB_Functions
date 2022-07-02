function barSTD(A,C)
% barSE(A,C)
% A: cell (repetition x category)
% C: color matrix (2 x 3)

n = size(A,2); % number of categories
bw = .25; % bar width
lw = 3; % line width

% plot(nanmean(A,1),'o','markerfacecolor',C,'markeredge','none','markersize',8)

for i = 1:n
    count = sum(~isnan(A{:,i}));
    STD(i) = nanstd(A{:,i},1)
    fill([i-bw,i+bw,i+bw,i-bw],[0 0 nanmean(A{:,i}) nanmean(A{:,i})],C(i,:),'facealpha',1,'edgecolor','none');
    hold on
    line([i i],[nanmean(A{:,i})-STD(i) nanmean(A{:,i})+STD(i)],'linewidth',lw,'color',[.5 .5 .5])
    Avg(i) = nanmean(A{:,i});
end
xlim([0 n+1])
ylim([min(Avg)-5*max(STD) max(Avg)+5*max(STD)])
set(gca,'xtick',1:n,'tickdir','out')
box off