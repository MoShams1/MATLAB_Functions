% linebar 1.0
% 02/04/2019
% Mohammad Shams
% m.shamsahmar@gmail.com

function linebar(A)
% A: a matrix. columns must be cetegories

ncat    = size(A,1); % number of data in each category
msz     = 200; % marker size
cline   = [.6 .6 .6]; % line color
cmarker = [0 0 0]; % marker color

for i = 1:ncat
    plot([1 2],[A(i,1) A(i,2)],'color',cline)
    hold on
end
scatter(1*ones(ncat,1),A(:,1),msz,'.','markeredgecolor',cmarker);
scatter(2*ones(ncat,1),A(:,2),msz,'.','markeredgecolor',cmarker);

xlim([0 3])
set(gca,'xtick',1:2)
