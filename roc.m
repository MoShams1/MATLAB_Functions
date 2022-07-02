% roc v.2
% 03.Oct.2020
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% auc = roc(A, B, pl)
% A: column 1 (The greater vector)
% B: column 2 (The smaller vector)
% pl: plot ROC curve

function [auc] = roc(A, B, pl)

if isempty(A) | isempty(B)
    error('At least one the inputs is empty.')
end
if sum(isnan(A))==length(A) | sum(isnan(B))==length(B)
    error('At least one the inputs is all NaN')
end

a2z = unique( sort([A ; B]) );
% a2z(isnan(a2z)) = [];
x = nan(1,length(a2z));
y = nan(1,length(a2z));

for i = 1:length(a2z)
    
    pTP = sum(A>a2z(i)) ./ sum(A~=a2z(i));
    pFP = sum(B>a2z(i)) ./ sum(B~=a2z(i));
    
    x(i) = pFP;
    y(i) = pTP;

end

auc = -trapz(x,y);

switch nargin
    case 3
        if pl
            plot(x,y,'linewidth',2)
            line([0 1],[0 1],'linestyle','--')
            title ('ROC Curve')
            xlabel p(FP)
            ylabel p(TP)
            set(gca, 'xtick',[0:.2:1] , 'ytick',[0:.2:1])
            text(.75, .05, ['AUC: ',num2str(auc)])
            cleanplot
%             ylim([-.01 1.01])
%             xlim([-.01 1.01])
        end
end