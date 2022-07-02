function O = binmatrix(X,b,M)
% plotBin(X,b,M)
% X: trial x time
% b: number of bins
% M: output mode -> [0]blocks [1]lines

% add tails to make the length dividable
r = rem(b-rem(size(X,1),b),b);
X = [X;nan(r,size(X,2))];
w = size(X,1)/b;
n = size(X,2); % number of points

if M
    for i = 1:b
        O{i,:} = nanmean(X(i*w-w+1:i*w,:));
    end
else
    for i = 1:b
        O{i,1} = X(i*w-w+1:i*w,:);
    end
end
