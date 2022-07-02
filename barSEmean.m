function barSEmean(A,E)
% barSEmean(A,C,E)
% A: cell or mat (repetition x category), comma separated!
% C: color matrix (category x 3)
% E: on/off errorbars (1/0)

if isnumeric(A)
    for icol = 1:size(A,2)
        A_cell{icol} = A(:,icol);
    end
    A = A_cell;
end

ncat = numel(A); % number of categories
bw = .15; % bar width
lw = 3; % line width
c = lines(7);

for i = 1:ncat
    fill([i-bw,i+bw,i+bw,i-bw],[0 0 nanmean(A{i}) nanmean(A{i})],c(i,:),'edgecolor','none');
    hold on    
end

if E
    for i = 1:ncat
        count = sum(~isnan(A{i}));
        s(i) = nanstd(A{i},1) / (count.^.5);
        m(i) = nanmean(A{i});
        
        line([i i],[nanmean(A{i})-s(i) nanmean(A{i})+s(i)],'linewidth',lw,'color','k')        
    end    
end

line([0 ncat+1],[0 0],'color','k')

xlim([0 ncat+1])

if max(s)==0
    ylim([min(m)-(max(m)-min(m))/2 max(m)+(max(m)-min(m))/2])
else
    ylim([min(m)-2*max(s) max(m)+2*max(s)])
end

set(gca,'xtick',1:ncat)