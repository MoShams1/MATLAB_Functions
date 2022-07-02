% Mohammad Shams
% m.shamsahmar@gmail.com
% 29.June.2021
%
% Calculates the probability of at least k consecutive successes in n binomial trials
% whith the success probability of p
%
% Original reference:
% An Introduction to Probability Theory and Its Applications
% by William Feller | 3rd Ed. | p.325 | eq.7.11
%
% via:
% https://math.stackexchange.com/questions/417762/probability-of-20-consecutive-success-in-100-runs/420724
%
% phat = consecutive_binomial(n,k,p)
% n: number of trials
% k: number of consecutive successes
% p: success probability


function phat = consecutive_binomial(n,k,p)

    q = 1-p;
    
    % [step one]
    % find the closest x to 1, that satisfies the equation below:    
    % (qp^k)x^(k+1) - x + 1 = 0
    
    coeff = zeros(1,k+2);
    
    coeff(1)        = q*p^k;
    coeff(end-1)    = -1;
    coeff(end)      = 1;
    
    r = roots(coeff);
    
    [~, ir] = min(abs(r-1));
    x = r(ir);
    
    
    
    % [step two]
    % approximate the probability of no consecutive success of length k in n trials
    % q ~ (1-px) / [(k+1-kx)(q)(x^(n+1))]
    
    qhat = (1-(p*x)) / ((k+1-k*x)*q*x^(n+1));
    
    
    
    % [step three]
    % return the complementary probability of q
    
    phat = 1-qhat;
    