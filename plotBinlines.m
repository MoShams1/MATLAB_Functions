function plotBinlines(X,b,C,E,S,M)
% plotBin(X,b,C,E,S,M)
% X: trial x time
% b: number of bins
% C: color
% E: standard error
% S: smooth window
% M: marker

% add tails to make the length dividable
r = rem(b-rem(size(X,1),b),b);
X = [X;nan(r,size(X,2))];
w = size(X,1)/b;
n = size(X,2); % number of points
lw = 1; % Line Width

for i = 1:size(X,1)
    X(i,:) = smooth(X(i,:),S);
end

if E
    a = .5; % Alpha (Transparecy)
else
    a = 0;
end

for i = 1:b
    A = X(i*w-w+1:i*w,:);
    
    if M
        h = plot(nanmean(A,1),'color',C(i,:),'linewidth',lw,'marker','o','markerfacecolor',C(i,:));
    else
        h = plot(nanmean(A,1),'color',C(i,:),'linewidth',lw);
    end

    for j = 1:size(A,2)
        notnan(j,1) = sum(~isnan(A(:,j)));
    end

    up = nanmean(A) + nanstd(A,1) ./ (notnan.^.5);
    dn = nanmean(A) - nanstd(A,1) ./ (notnan.^.5);

    hold on
    fill([1:length(up) length(up):-1:1],[up;flipud(dn)],C(i,:),'facealpha',a,'edgecolor','none')
    clear A
end

xlim([0 n+1])
set(gca,'tickdir','out')
box off

