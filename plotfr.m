%
% plotfr v1.0
% 05.10.2020
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% Plots the estimated firing rate of a neural raster
%
% [plot_hangle, convolved_raster] = plotfr(x,raster,kernel_std,color)
%

function [h,rasterk] = plotfr(x,raster,kernel_std,c);

ntrial = size(raster,1);
T = size(raster,2);

% set the kernel width
kstd = 6;   % set the kernel width large enough to preserve the energy of each kernel
            % but also small enough to avoid artifacts at tails
kernel_width = kstd * kernel_std;

% find the half size kernel
hk = ceil(kernel_width/2);

% create the normalized gaussian kernel (if kernel_std large enough => kernel's are = 1)
xkernel = -hk:hk;
kernel = normpdf(xkernel,0,kernel_std);

% go across trials
for itrial = 1:ntrial
    
    % focus on one trial
    train = raster(itrial,:);
    
    % localize spikes in the trial
    spike_times = find(train==1);
    
    % pre-allocate a matrix for each trial (nSpikes,nTime-bins)
    train_conv = nan(length(spike_times),T+2*hk);
    
    % go to each spike in the trial
    row = 0;
    for ispike = spike_times+hk % a half size kernel is added to update the spike times with respect to the train_conv vector
        
        % store each convolved spike in a separate row of the pre-allocated matrix
        row = row+1;
        train_conv(row,ispike-hk:ispike+hk) = kernel;
        
    end
    
    % average across the kernels in each time bin
    rasterk(itrial,:) = nansum(train_conv,1); % 'sum' is used to preserve the energy of each kernel
    
end

% crop the extra time-bins as side product of the convolution process
rasterk(:,1:hk) = [];
rasterk(:,end-(hk-1):end) = [];

% plot the average firing rate across trials
h = ploter(x,rasterk*1000,c,1);

% indicate regions at both tails that are subject to be artifact
y = ylim;
down = hk;    % the first time-bin that starts to be potentially influenced by kernels from both sides is 'hk+1'
up = T-hk+1;  % the last time-bin that still can be potentially influenced by kernels from both sides is 'T-hk'
hold on
fill([x(1) x(1)+down x(1)+down x(1)],[y(1) y(1) y(2) y(2)],'k','edgecolor','none','facealpha',.3);
fill([up+x(1) x(end) x(end) up+x(1)],[y(1) y(1) y(2) y(2)],'k','edgecolor','none','facealpha',.3);
