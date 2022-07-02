% shades(c,n)
% Mohammad Shams
% 2021-07-14
% m.shamsahmar@gmail.com
%
% c: color x RGB
% n: total needed colors

function cmap = shades4(c,n)

n = floor(n/3);

for irgb = 1:3
    cmap1(:,irgb) = linspace(c(1,irgb),c(2,irgb),n);
end
for irgb = 1:3
    cmap2(:,irgb) = linspace(c(2,irgb),c(3,irgb),n+1);
end
for irgb = 1:3
    cmap3(:,irgb) = linspace(c(3,irgb),c(4,irgb),n+1);
end

if mod(n,3)==1
    cmap2(1,:) = [];

elseif mod(n,3)==2
    cmap2(1,:) = [];
    cmap3(1,:) = [];

end

cmap = [cmap1;cmap2;cmap3];

end