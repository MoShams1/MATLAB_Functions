function [p, Y] = binscatter_shams(A,n,C,pl)
% [p,Y] = Binscatter(A,n,C,pl)
% A: scatter matrix (dots x 2)
% n: number of bins
% C: color
% p: figure elements
% Y: mean values

% line width
lw = 1.5;

[~,ind] = sort(A(:,1));
BX = A(ind,1);
BY = A(ind,2);

% add tails to make the length dividable
r = rem(n-rem(size(BX,1),n),n);
BX = [BX;nan(r,1)];
BY = [BY;nan(r,1)];

% bin
BX = reshape(BX,[size(BX,1)/n,n]);
BY = reshape(BY,[size(BY,1)/n,n]);
X = nanmean(BX);
Y = nanmean(BY);
E = nanstd(BY) ./ sqrt(sum(~isnan(BY),1));
p = [];
if pl
    % plot
    p = plot(X,Y,'color',C,'linewidth',lw);

    hold on
    for i = 1:n
        line([X(i) X(i)],[Y(i)-E(i) Y(i)+E(i)],'color',C,'linewidth',lw)
    end
end
