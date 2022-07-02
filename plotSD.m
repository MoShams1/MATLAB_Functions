function h = plotSD(x,A,C,S)
% plotSD(A,C,E,S,M)
% INPUTS--------
% A: matrix (repetition x time)
% C: color
% E: standard error
% S: smooth window
% M: marker
% OUTPUTS-------
% h: plot handle

n = size(A,2);  % number of points
w = 1;          % Line Width

for i = 1:size(A,1)
    A(i,:) = smooth(A(i,:),S,'lowess');
end

% if E
a = .5; % Alpha (Transparecy)
% else
%     a = 0;
% end


h = plot(x,nanmean(A,1),'color',C,'linewidth',w);

if size(A,1)>1
    up = nanmean(A,1) + nanstd(A,[],1);
    dn = nanmean(A,1) - nanstd(A,[],1);
    hold on
    fill([1:length(up) length(up):-1:1],[up,fliplr(dn)],C,'facealpha',a,'edgecolor','none')
end

xlim([0 n+1])
