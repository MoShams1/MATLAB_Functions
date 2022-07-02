%
% pop2fr v1.0
% 07.10.2020
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% Estimates the firing rate of neural population given as a cell of rasters
%
% convolved_population_raster = pop2fr(population_raster,kernel_std)
%
% INPUT
% population_raster: an array of cells, where each element consists of a neural raster
% kernel_std: the standard deviation of the Gaussian kernel
%
% OUTPUT
% convolved_population_raster = a (m x n) matrix, where each row is the estimated firing rate of the m-th neuron and n is time
%

function pop_raster_conv = pop2fr(pop_raster,std)

% go to each neuron (element of the cell array)
for ineuron = 1:size(pop_raster,1)
    
    % extract the current raster
    raster = pop_raster{ineuron,1};
    
    % check if the neuron exists
    if ~isempty(raster)
        % convolve each trial/row of the raster with a Gaussian kernel with a defined standard deviation
        raster_conv = raster2fr(raster,std);
        
        % estimate the firing rate of the raster by taking an average across trials/rows
        pop_raster_conv(ineuron,:) = nanmean(raster_conv,1);
        
    else
        % assign NaN to the corresponding row in the output matrix if the neuron does not exist
        pop_raster_conv(ineuron,:) = nan;
    end
    
end