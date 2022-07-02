function barSEmedian(A,C,E)
% barSE(A,C,E)
% A: cell (repetition x category), comma separated!
% C: color matrix (category x 3)
% E: on/off errorbars (1/0)

n = size(A,2); % number of categories
bw = .25; % bar width
lw = 3; % line width

% plot(nanmedian(A,1),'o','markerfacecolor',C,'markeredge','none','markersize',8)

for i = 1:n
    fill([i-bw,i+bw,i+bw,i-bw],[0 0 nanmedian(A{:,i}) nanmedian(A{:,i})],C(i,:),'facealpha',1,'edgecolor','none');
    hold on    
end

if E
    for i = 1:n
        count = sum(~isnan(A{:,i}));
        s(i) = nanstd(A{:,i},1) / (count.^.5);
        m(i) = nanmedian(A{:,i});
        
        line([i i],[nanmedian(A{:,i})-s(i) nanmedian(A{:,i})+s(i)],'linewidth',lw,'color',[.5 .5 .5])        
    end
    
end

line([0 n+1],[0 0],'color','k')

xlim([0 n+1])

if max(s)==0
    ylim([min(m)-(max(m)-min(m))/2 max(m)+(max(m)-min(m))/2])
else
    ylim([min(m)-2*max(s) max(m)+2*max(s)])
end

set(gca,'xtick',1:n)