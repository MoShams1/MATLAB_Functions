% shuffle_rows v1.0
% 2021-04-15
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% Shuffles rows of matrix A

function Ash = shuffle_rows(A)

n = size(A,1);
Ash = A(randperm(n),:);