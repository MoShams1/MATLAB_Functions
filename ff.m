% ff v1.0
% 07-01-2021
% Mohammad Shams
% m.shamsahmar@gmail.com

function F = ff(A,w)

summat = nan(size(A));
center = floor(w/2);
for i = 1:size(A,1)
    for j = 1:size(A,2)-w
        summat(i,j+center) = sum(A(i,j:j+w),2);
    end
end
F = nanvar(summat,[],1)./nanmean(summat);
