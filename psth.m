% psth 2.0
% 01/05/2018
% Mohammad Shams
% m.shamsahmar@gmail.com

function h = psth(M,binsz)

ntrials = sum(~isnan(M(:,1)));
MV = nansum(M,1);
Vb = nansum(reshape(MV,binsz,[]));
Vraw = repelem(Vb,binsz);
V = Vraw ./ binsz ./ ntrials;

hh = area(V);

if nargout == 1
    h = hh;
end
