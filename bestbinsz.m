function optb = bestbinsz(M)

M(isnan(M(:,1)),:) = [];
n = size(M,1);
M = sum(M,1);
c = 0;
dset =  [1 2 5 10 20 50 100];
for delta = dset
    c = c+1;
    B = reshape(M,delta,[]);
    count = sum(B);
    k = mean(count);
    v = var(count);
    
    C(c) = (2*k-v)/((n*delta).^2);
end

[~,idx] = min(C);
optb = dset(idx);
