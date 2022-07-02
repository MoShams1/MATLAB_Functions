% errorbarplot 1.0 (16/05/2020)
% Mohammad Shams
% m.shamsahmar@gmail.com
% ---------------------------------------------
% errorbarplot(A)
% INPUTS--------
% A: matrix (repetition x time)
% C: color

function h = errorbarplot(A)

count_per_column = sum(~isnan(A),1);
h = plot(1:size(A,2),nanmean(A,1));
up = nanmean(A,1) + (nanstd(A,0,1) ./ count_per_column.^.5);
dn = nanmean(A,1) - (nanstd(A,0,1) ./ count_per_column.^.5);

c = get(h,'color');
hold on
for it = 1:size(A,2)
    line([it it],[dn(it) up(it)],'color',c)
end