% starplot v1 (28.05.2020)
% Mohammad Shams
% m.shamsahmar@gmail.com

function starplot(Cx,Cy)

nclusters = size(Cx,2);

mx = mean(Cx,1);
my = mean(Cy,1);
sx = std(Cx,1);
sy = std(Cy,1);

hold on
c = lines(7);
msz = 100;

for ic = 1:nclusters
    scatter(mx(ic),my(ic),msz,'markeredgecolor','none','markerfacecolor',c(ic,:))
    line([mx(ic)-sx(ic) mx(ic)+sx(ic)],[my(ic) my(ic)],'color',c(ic,:))
    line([mx(ic) mx(ic)],[my(ic)-sy(ic) my(ic)+sy(ic)],'color',c(ic,:))
end
    