%
% plotpopfr v1.0
% 06.10.2020
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% Plots the estimated firing rate of a neural population raster
%
% [plot_hangle, convolved_raster] = plotfr(x,population_raster,kernel_std,sampling_rate,normalization,color,unreliable_margins)
%

function [h,rasterk] = plotpopfr(x,popraster,kernel_std,sr,norm,c,margin);

% set the kernel width
kstd = 10;   % set the kernel width large enough to preserve the energy of each kernel
% but also small enough to avoid artifacts at tails
kernel_width = kstd * kernel_std;

% find the half size kernel
hk = ceil(kernel_width/2);

% create the normalized gaussian kernel (if kernel_std large enough => kernel's are = 1)
xkernel = -hk:hk;
kernel = normpdf(xkernel,0,kernel_std);


for is = 1:size(popraster,1)
    
    ntrial = size(popraster{is,1},1);
    T = size(popraster{is,1},2);
    
    % go across trials
    for itrial = 1:ntrial
        
        % focus on one trial
        train = popraster{is,1}(itrial,:);
        
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
    
    % check if a normalization was requested
    if norm
        % return the zscored average across trials in the session
        poprasterk(is,:) = zscore(mean(rasterk,1));
    else
        % return the average across trials in the session converted to Hz
        poprasterk(is,:) = mean(rasterk,1)*sr;
    end
end


% crop the extra time-bins as side product of the convolution process
poprasterk(:,1:hk) = [];
poprasterk(:,end-(hk-1):end) = [];

% plot the average firing rate across trials
% h = ploter(x,poprasterk,c,1);
plotAll(x,poprasterk,c);

% check if margins were requested
if margin
    % indicate regions at both tails that are subject to be artifact
    y = ylim;
    down = hk;    % the first time-bin that starts to be potentially influenced by kernels from both sides is 'hk+1'
    up = T-hk+1;  % the last time-bin that still can be potentially influenced by kernels from both sides is 'T-hk'
    hold on
    fill([x(1) x(1)+down x(1)+down x(1)],[y(1) y(1) y(2) y(2)],'k','edgecolor','none','facealpha',.5);
    fill([up+x(1) x(end) x(end) up+x(1)],[y(1) y(1) y(2) y(2)],'k','edgecolor','none','facealpha',.5);
end
