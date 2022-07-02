% plot3line
% last update: 15-Jan-2022
% Mohammad Shams
% m.shamsahmar@gmail.com

function h = plot3line(x,A,color,crop,std)

switch nargin
    case 2
        color = lines(1);
        crop = 0;
    case 3
        crop = 0;
end

if isempty(x)
    x = 1:size(A,2);
end

if ~iscell(A)
    if crop
        A(:,1:3*std) = nan;
        A(:,end-(3*std)+1:end) = nan;
    end
    m = nanmean(A,1);
    err = SE(A);
else    
    for ic = 1:numel(A)
        m(ic) = nanmean(A{ic});
        err(ic) = SE(A{ic});
    end
end

hold on
h = plot(x,m,'color',color,'linewidth',2);
plot(x,m-err,'color',color,'linewidth',.5)
plot(x,m+err,'color',color,'linewidth',.5)
