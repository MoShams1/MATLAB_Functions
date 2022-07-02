% shades(c,n)
% Mohammad Shams
% 2021-07-14
% m.shamsahmar@gmail.com
%
% c: color x RGB
% n: total needed colors

function cmap = shades2(c,n)

for irgb = 1:3
    cmap(:,irgb) = linspace(c(1,irgb),c(2,irgb),n);
end

end