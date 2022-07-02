% matcher 1.0
% 11/02/2019
% Mohammad Shams
% m.shamsahmar@gmail.com
% ---------------------------------------------
% [A1_matched,A2_matched,samind1,samind2] = matcher(A1,A2,B1,B2)
% returns matched A's with respect to B's
%
% INPUTS--------
% A1: a vector of parameter A in condition 1
% A2: a vector of parameter A in condition 2
% B1: a vector of parameter B in condition 1
% B2: a vector of parameter B in condition 2
%
% OUTPUTS-------
% A1_matched: matched version of A1
% A2_matched: matched version of A2
% samind1: indexes of matching survived elements in A1
% samind2: indexes of matching survived elements in A2

function [A1_matched,A2_matched,samind1,samind2] = matcher(A1,A2,B1,B2)

B = [B1;B2];

[nB,edgeB] = histcounts(B);
[nB1,~,tagB1] = histcounts(B1,edgeB);
[nB2,~,tagB2] = histcounts(B2,edgeB);
nmin = min(nB1,nB2);

for ibin = 1:length(nB)

    allind1 = find(tagB1 == ibin);
    samind1_c{ibin,1} = datasample(allind1,nmin(ibin),'replace',false);
    A1_matched_c{ibin,1} = A1(samind1_c{ibin,1});
    B1_matched_c{ibin,1} = B1(samind1_c{ibin,1});

    allind2 = find(tagB2 == ibin);
    samind2_c{ibin,1} = datasample(allind2,nmin(ibin),'replace',false);
    A2_matched_c{ibin,1} = A2(samind2_c{ibin,1});
    B2_matched_c{ibin,1} = B2(samind2_c{ibin,1});

end
samind1 = cell2mat(samind1_c);
samind2 = cell2mat(samind2_c);
A1_matched = cell2mat(A1_matched_c);
A2_matched = cell2mat(A2_matched_c);

    



