function [p, avgA] = binline(A,n,C,pl)
% [p,Y] = Bindots(A,n,C,pl)
% INPUTS
% A: a vector
% n: number of bins
% C: color
% pl: plot/not plot
% OUTPUTS
% p: figure elements
% avgA: the average bin points

% line width
lw = 2;

% add tails to make the length dividable
r = rem(n-rem(size(A,1),n),n);
A = [A;nan(r,1)];

% bin
A = reshape(A,[n,length(A)/n]);
avgA = nanmean(A,1);
errA = nanstd(A,1) ./ sqrt(sum(~isnan(A),1));
p = [];
if pl
    % plot
    p = plot(avgA,'color',C,'linewidth',lw);

%     hold on
%     for i = 1:n
%         line([avgA(i) avgA(i)],[avgA(i)-errA(i) avgA(i)+errA(i)],'color',C,'linewidth',lw)
%     end
end
