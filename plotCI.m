% plot95
% 21-Apr-2021
% Mohammad Shams
% m.shamsahmar@gmail.com

function h = plot95(A,color,crop,std)

switch nargin
    case 1
        color = lines(1);
        crop = 0;
    case 2        
        crop = 0;
end


if crop
    A(:,1:3*std) = nan;
    A(:,end-(3*std)+1:end) = nan;
end

nitems = size(A,2);

for icol = 1:nitems
    
    q = sort(A(:,icol));
    
    cut_low  = round(.025*nitems);
    cut_high = round(.975*nitems);
           
    CI(1,icol) = q(cut_low);
    CI(2,icol) = q(cut_high);
    
end


hold on
h = plot(CI(1,:),'color',color,'linewidth',.5);
plot(CI(2,:),'color',color,'linewidth',.5)

xlim([0 nitems+1])