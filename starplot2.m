% starplot2 v1 (28.05.2020)
% Mohammad Shams
% m.shamsahmar@gmail.com

function starplot2(Cx,Cy)

nclusters = numel(Cx);

hold on
c = lines(7);
msz = 100;

mx = cellfun(@nanmean, Cx);
sx = cellfun(@nanstd, Cx);
my = cellfun(@nanmean, Cy);
sy = cellfun(@nanstd, Cy);

for ic = 1:nclusters
    scatter(mx(ic),my(ic),msz,'markeredgecolor','none','markerfacecolor',c(ic,:))
    line([mx(ic)-sx(ic) mx(ic)+sx(ic)],[my(ic) my(ic)],'color',c(ic,:))
    line([mx(ic) mx(ic)],[my(ic)-sy(ic) my(ic)+sy(ic)],'color',c(ic,:))
end