% wtest v1.0
% 29.10.2020
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% returns the Wilcoxon signed rank test statistic (W)
% and in case of an approximation the corresponding z value
function wtest(a,b)

ninput = nargin;

switch ninput
    
    case 1
        [~,~,stats] = signrank(a);
        
        W = stats.signedrank
        if isfield(stats,'zval')
            z = stats.zval
        end
        
        
    case 2
        [~,~,stats1] = signrank(a,b);
        [~,~,stats2] = signrank(b,a);
        
        if stats1.signedrank < stats2.signedrank
            W = stats1.signedrank
            if isfield(stats1,'zval')
                z = stats1.zval
            end
        else
            W = stats2.signedrank
            if isfield(stats2,'zval')
                z = stats2.zval
            end
        end
        
end