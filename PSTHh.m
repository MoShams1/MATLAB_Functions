function PSTHh(A,w,C)
% PSTHh(A,w,C)
% A: trial x time
% w: bin width
% C: faceColor

n = size(A,2);

% count CS's over time
A = sum(A,2)';

% add tails to make the length dividable
r = rem(w-rem(length(A),w),w);
A = [A,nan(1,r)];

% bin trial
A = reshape(A,[w,length(A)/w]);
S = nansum(A);

% calculate spike/sec
w2 = sum(~isnan(A));
S = 1000 * S ./ (n * w2);
barh(S,1,'facecolor',C,'edgecolor','none'),cleanplot
ylim([.5 length(w2)+.5])
set(gca,'ydir','reverse')