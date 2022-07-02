% psth 1.0
% 26/03/2018
% Mohammad Shams
% m.shamsahmar@gmail.com

function h = psth2(V,T)

H = repelem(1:length(V),V);
hh = histogram(H,T,'displaystyle','stairs','norm','countdensity');
if nargout == 1
    h = hh;
end
