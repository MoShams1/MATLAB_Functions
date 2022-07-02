% plot95
% last update: 15-Jan-2022
% Mohammad Shams
% m.shamsahmar@gmail.com

function h = plot95(x,A,color,crop,std)

switch nargin
    case 1
        color = lines(1);
        crop = 0;
    case 2        
        crop = 0;
end

if isempty(x)
    x = 1:size(A,2);
end

if crop
    A(:,1:3*std) = nan;
    A(:,end-(3*std)+1:end) = nan;
end

n_times = size(A,2);
n_samples = size(A,1);

for icol = 1:n_times
    
    q = sort(A(:,icol));
    
    cut_low  = round(.025*n_samples);
    cut_high = round(.975*n_samples);
           
    up(1,icol) = q(cut_low);
    down(2,icol) = q(cut_high);
    
end

hold on
h = plot(x,mean(A,1),'color',color,'linewidth',2);
plot(x,up(1,:),'color',color,'linewidth',.5);
plot(x,down(2,:),'color',color,'linewidth',.5)
