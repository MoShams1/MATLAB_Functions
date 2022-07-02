% shades(c,n)
% Mohammad Shams
% 2021-07-14
% m.shamsahmar@gmail.com
%
% c: color x RGB
% n: total needed colors

function cmap = shades3(c,n)

n = floor(n/2);

for irgb = 1:3
    cmap1(:,irgb) = linspace(c(1,irgb),c(2,irgb),n);
end
for irgb = 1:3
    cmap2(:,irgb) = linspace(c(2,irgb),c(3,irgb),n+1);
end

if mod(n,2)==0
    cmap2(1,:) = [];
end

cmap = [cmap1;cmap2];

end