% Holm_correct
% 26.June.2021
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% correct pvalues for multiple comparisons using Holm method
% INPUTS
% pval: originally calculated pvalues
% alpha: alpha level
% side:  [DEFAULT] two-sided(2) | one-sided(1)
% OUTPUT
% sig: a logical vector indicating significant pvalues after correction

function [sig, alpha_hat] = Holm_correct(pval,alpha,side)

n = nargin;

if n<3
    side = 2;
end

n = length(pval);

[~, ind] = sort(pval);
rank = 1:n;

alpha_hat_sort = alpha./(n+1-rank);
alpha_hat(ind) = alpha_hat_sort;

switch side
    case 1
        sig = pval<alpha_hat;
    case 2
        sig = pval<(alpha_hat/2);
end
end