function S = PSTHh(A,b,C,p)
% PSTHh(A,w,C)
% A: trial x time
% b: bin number
% C: faceColor

n = size(A,2);

% count CS's over time
A = sum(A,2)';

% add tails to make the length dividable
r = rem(b-rem(length(A),b),b);
A = [A,nan(1,r)];

% bin trial
A = reshape(A,[length(A)/b,b]);
S = nansum(A);

% calculate spike/sec
w2 = sum(~isnan(A));
S = S ./ (n * w2);
if p
    barh(S,1,'facecolor',C,'edgecolor','none'),cleanplot
    ylim([.5 length(w2)+.5])
    set(gca,'ydir','reverse')
end
