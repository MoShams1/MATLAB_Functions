function P = nnclass(x, y, nclass, ntrain)
% P = nnclass(x, y, nclass, ntrain)
%
% Input arguments
%   x: m by n matrix
%       m: features
%       n: observations
%   y: 1 by j matrix
%       j: label/target of each observation
%   nclass: number of classes
%   ntrain: number of training subsets
%
% Output
%   P: preformance in percentage
%

ntest = size(x,2)/nclass - ntrain;

% build train and test masks
nall = ntrain + ntest;
indAll = 1:nall;
indTrn = randperm(nall,ntrain);
maskTrn = zeros(1,nall);
for i=1:ntrain
    maskTrn = maskTrn | (indTrn(i) == indAll);
end
maskTst = ~maskTrn;
maskTrn = double(maskTrn);
maskTst = double(maskTst);
maskTrn(maskTrn==0)=nan;
maskTst(maskTst==0)=nan;

sizex_1 = size(x,1);
maskTrn = repmat( maskTrn , sizex_1,nclass );
maskTst = repmat( maskTst , sizex_1,nclass );

% extract train-subset and test-subset from data
xTrn = x .* maskTrn;
yTrn = y .* maskTrn(1,:);
xTst = x .* maskTst;
yTst = y .* maskTst(1,:);

xTrn(:,isnan(yTrn)) = [];
xTst(:,isnan(yTst)) = [];
yTst(:,isnan(yTst)) = [];

% calculate class mean within train subset
cMeans = nan( sizex_1 , ntrain*nclass );
for c = 1:nclass
    cMeans(:,c) = mean( xTrn( : , (c-1)*ntrain+1:(c-1)*ntrain+ntest ) , 2);
end

% find the nearest class to each test column
disMat = nan(nclass,ntest);
for j = 1:ntest*nclass
    for c = 1:nclass
        disMat(c,j) = norm(xTst(:,j)-cMeans(:,c));
    end
end
[~, cWinners] = min(disMat,[],1);

% calculate the percentage of correct answers
P = sum(cWinners == yTst) / (ntest*nclass) * 100;
end