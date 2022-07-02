%% convert the scatterplot to plot with squared axes and a unity line
% 12/3/2019
% Mohammad Shams
% m.shamsahmar@gmail.com

function unityline

axis square
x = xlim;
y = ylim;
xy1 = min(x(1),y(1));
xy2 = max(x(2),y(2));
line([xy1 xy2],[xy1 xy2],'color','k')
xlim([xy1 xy2])
ylim([xy1 xy2])