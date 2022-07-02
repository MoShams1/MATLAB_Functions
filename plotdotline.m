% plotdotline
% 07-May-2021
% Mohammad Shams
% m.shamsahmar@gmail.com

function h = plotdotline(A,color,connect)

switch nargin
    case 1
        color = lines(1);
        connect = 0;
    case 2
        connect = 0;        
end

m = nanmean(A,1);
err = SE(A);

hold on
for i = 1:size(A,2)
    plot(line([i i],[m(i)-err(i) m(i)-err(i)],'color',color','linewidth',1)
end

if ~connect
    h = plot(m,'o','markerfacecolor',color,'markeredgecolor','none');
elseif connect
    h = plot(m,'-o','markerfacecolor',color,'markeredgecolor','none');
end

xlim([0 size(m,2)+1])