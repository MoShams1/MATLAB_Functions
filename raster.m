% raster v1.0
% 05.03.2018
% Mohammad Shams
% m.shamsahmar@gmail.com
%------------------------
% raster(N,C,sz)
% N: input matrix (trial x time)
% C: color (default = black)
% sz: dot size (default = 10)

function raster(N,C,sz)
switch nargin
    case 1
        C = 'k';
        sz = 5;
    case 2
        sz = 5;
end
N(isnan(N)) = 0;
[y, x] = find(N);
plot(x,y,'MarkerSize',sz,'Marker','.','LineStyle','none','Color',C);
axis ij

xlim([0 size(N,2)+1])
ylim([0 size(N,1)+1])
