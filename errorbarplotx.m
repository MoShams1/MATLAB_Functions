% errorbarplot 1.0 (05/06/2020)
% Mohammad Shams
% m.shamsahmar@gmail.com
% ---------------------------------------------
% errorbarplot(x,A)
% INPUTS--------
% A: matrix (repetition x time)
% C: color

function h = errorbarplotx(x,A)

count_per_column = sum(~isnan(A),1);
h = plot(x,nanmean(A,1));
up = nanmean(A,1) + (nanstd(A,0,1) ./ count_per_column.^.5);
dn = nanmean(A,1) - (nanstd(A,0,1) ./ count_per_column.^.5);

c = get(h,'color');
hold on
for it = 1:size(A,2)
    line([x(it) x(it)],[dn(it) up(it)],'color',c)
end