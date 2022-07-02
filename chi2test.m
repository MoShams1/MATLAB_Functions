% chi2test v1.0
% 30.10.2020
%
% chi2test v1.1
% (nAll derives now from nObs)
% 17.06.2021
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% [p chi2] = chi2test(nobs,nall,pexp)
% tests the null hypothesis that the proportion of observed outcomes are similar to the expeted ones.
%
% nObs: frequency of the desired outcome
% pExp: expected probability of the desired outcome
% p:    the p-value
% chi2: test statistic chi squared

function [p, chi2] = chi2test(nObs,pExp)

% calculate the degrees of freedom
df = length(nObs)-1;

% calculate total observations
nAll = sum(nObs);

% calculate the expected number of observations for each outcome
nExp = nAll.*pExp;

% calculate the chi squared and the p-value
chi2 = sum( ((nObs-nExp).^2) ./ nExp ); 
p = 1-chi2cdf(chi2,df);
