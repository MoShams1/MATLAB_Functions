
% a minimal function for saccade onset time detection
% 12/08/2019
% Mohammad Shams (m.shamsahmar@gmail.com)
%
% inputs:
%  - eye x (cell(trial,1))
%  - eye y (cell(trial,1))
%  - smooth window
%  - onset velocity threshold
%
% output:
%  - onset time
%------------------------------------------

function on_time = findsac(x,y,sw,onth)

fprintf('Detecting saccades...')

% valid peak velocity range
vmin = 100;
vmax = 800;

% in every trial
for itrial = 1:numel(x)
    
    eyex_raw = x{itrial};
    eyey_raw = y{itrial};
    
    % Use local regression smoothing for the eye data
    eyex = smooth(eyex_raw,sw,'loess');
    eyey = smooth(eyey_raw,sw,'loess');
    
    % Calculate velocity profiles
    velx = 1000*diff(eyex);
    vely = 1000*diff(eyey);
    
    vel = sqrt(velx.^2 + vely.^2);
    
    [pv_val,pv_time]  = findpeaks(vel);
    
    invalid = pv_val<vmin | pv_val>vmax | pv_time<50;
    
    pv_val (invalid) = [];
    pv_time(invalid) = [];
    
    % DETECT FIRST POINTS AROUND THE PEAK WHICH ARE BELOW THE THRESHOLD, AS THE ON/OFF-SET OF THE SACCADE
    if ~isempty(pv_time)        
        ksac = 0;
        % for every nominated local maximum
        for ilocMax = 1:numel(pv_time)
            % find the first point below the threshold before the local maximum/minimum
            pre_pv = vel( pv_time(ilocMax)-49 : pv_time(ilocMax) );
            below_thresh = find( pre_pv < onth );
            
            if ~isempty(below_thresh)
                ksac = ksac+1;
                on_time{itrial,1}(ksac,1)  = pv_time(ilocMax) - (50-below_thresh(end));
            end
        end
        
    end
    
end

fprintf('Done\n')

