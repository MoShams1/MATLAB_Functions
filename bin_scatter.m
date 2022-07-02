function p = bin_scatter(A,n,C,pl)
% [p,Y] = bin_scatter(A,n,C,pl)
% A: scatter matrix (dots x 2)
% n: number of bins
% C: color
% p: figure elements
% Y: mean values

% line width
lw = 1.5;

x = A(:,1);
y = A(:,2);

qs = [min(x), quantile(x,n-1), max(x)];


for ibin = 1:n    
    ind = x>=qs(ibin) & x<qs(ibin+1);
    
    xb_m(ibin) = mean(x(ind));
    yb_m(ibin) = mean(y(ind));
    
    yb_e(ibin) = nanstd(y(ind)) ./ sqrt(sum(~isnan(y(ind))));    
end


if pl
    % plot
    p = plot(xb_m,yb_m,'color',C,'linewidth',lw);

    hold on
    for i = 1:n
        line([xb_m(i) xb_m(i)],[yb_m(i)-yb_e(i) yb_m(i)+yb_e(i)],'color',C,'linewidth',lw)
    end
end
