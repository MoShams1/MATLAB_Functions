% raster2 v2.0
% 09.11.2020
% Mohammad Shams
% m.shamsahmar@gmail.com
%------------------------
% raster(N,C,sz)
% N: input cell (element{trial x time})
% C: color (default = black)
% sz: dot size (default = 10)

function raster2(N,sz)

switch nargin    
    case 1
        sz = 10;
end

c = lines(7);

for i = 1:numel(N)
    block = N{i};
    block(isnan(block)) = 0;
    [y, x] = find(block);
    nt(i) = size(block,1);
    if i>1
        y = y + sum(nt(1:i-1));
    end
    plot(x,y,'MarkerSize',sz,'Marker','.','LineStyle','none','Color',c(i,:));
    hold on
end
% axis ij
nall = sum(nt);
xlim([0 size(block,2)+1])
ylim([0 nall+1])
