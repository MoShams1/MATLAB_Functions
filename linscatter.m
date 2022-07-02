% linscatter v1.0
% 07.12.2020
% Mohammad Shams
% m.shamsahmar@gmail.com

function [p, Ly,g] = linscatter(A,n,pl)
% [p,Y] = Binscatter(A,n)
% A: scatter matrix (items x coordination)
% n: number of bins
% p: plot handle
% Ly: line matrix
% g: group labels (for ANOVA/Kruskall-Wallis tests)

[~,~,bin] = histcounts(A(:,1),n);

for in = 1:n
    x(1,in) = nanmean(A(bin==in,1));
    y(1,in) = nanmean(A(bin==in,2));
    Ly{1,in} = A(bin==in,2);
    g{1,in} = in*ones(length(Ly{1,in}),1);
    e(1,in) = nanstd(Ly{1,in}) ./ sqrt(sum(~isnan(Ly{1,in}),1))
end

% plot
if pl
    p = errorbar(x,y,e);
end