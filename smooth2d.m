% smooth2d 1.0
% 2016
% Mohammad Shams
% m.shamsahmar@gmail.com

function B = smooth2d(A,wh,wv)

Bh = nan(size(A,1),size(A,2));
B = nan(size(A,1),size(A,2));
for i = 1:size(A,1)
    Bh(i,:) = smooth(A(i,:),wh,'loess');
end
for j = 1:size(A,2)
    B(:,j) = smooth(Bh(:,j),wv,'loess');
end



