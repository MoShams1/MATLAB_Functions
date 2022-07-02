%
%   findburst 1.0 (16.01.2020)
%   Mohammad Shams
%   m.shamsahmar@gmail.com
%   ----------------------
%   
%   out = findburst(A, nburst_max, pl)
%
%   A:            input matrix (trial x time) with spikes as ones
%   nburst_max    maximum number of bursts per trial
%   pl:           plot option (one: plot, zero: don't show)
%
%   out:          output cell {trial x 1}(nRankBurst x [onset_time, offset_time, SI])
%
function out = findburst(A, nburst_max, pl)


% CONSTANTS
% minimum number of spikes to define a burst
nspk_min = 2;
% coefficient of average past spike intervals as the maximum allowed gap between putative bursts
gap_coeff = 3;
% number of allowed drops in SI
SIdrop_max = inf;

if nargin>2 && pl
    figure
    raster(A,'k',5)
    xlabel time(ms)
    ylabel trial
    cleanplot
    
    c = lines(7);
end


for itrial = 1:size(A,1)
    
    trial = A(itrial,:);
    r = mean(trial);
    
    spktimes = find(trial==1);
    nspktrain = 0;
    
    spktrain = [];
    top_bursts = [];
    
    for i = 1:length(spktimes)-2
        
        down = 0;
        j = i+nspk_min-1;

        Tlast = spktimes(j)-spktimes(j-1);
        Tpast = Tlast;
        
        while down<SIdrop_max && sum(Tpast>gap_coeff*mean(Tpast))==0 && j<length(spktimes)
            
            j = j+1;
            
            T = spktimes(j)-spktimes(i);
            Tlast = spktimes(j)-spktimes(j-1);
            Tpast = [Tpast;Tlast];
            
            kk = 0;
            for ik = (j-i):T
                kk = kk+1;
                fact = prod(1:ik); % fast version for factorial and avoidance of duplicate calculation
                p(kk,1) = exp(-r*T)*(r*T)^ik/fact;
                if p(end)==inf || fact==inf
                    p(end) = [];
                    break
                end
            end
            nspktrain = nspktrain+1;
            spktrain(nspktrain,:) = [i,j,-log(sum(p))];
            p = [];
            
            if nspktrain>1 && spktrain(end,3)<spktrain(end-1,3)
                down = down+1;
            end
        end
        
    end
    
    if ~isempty(spktrain)
        
        spktrain = sortrows(spktrain,3,'desc');
        ntop_bursts = 1;
        top_bursts(ntop_bursts,:) = spktrain(1,:);
        covered = spktrain(1,1):spktrain(1,2);
        out{itrial,1}(ntop_bursts,:) = [spktimes(top_bursts(ntop_bursts,1)), spktimes(top_bursts(ntop_bursts,2)), top_bursts(ntop_bursts,3)];
        
        iburst = 1;
        while ntop_bursts<nburst_max && iburst<size(spktrain,1)
            
            iburst = iburst+1;
            
            switch ntop_bursts
                case 1
                    if spktrain(iburst,2)<spktrain(1,1) || spktrain(iburst,1)>spktrain(1,2) % this lifts some burden from the loop (using 'intersect' proved to be much slower)
                        ntop_bursts = ntop_bursts+1;
                        top_bursts(ntop_bursts,:) = spktrain(iburst,:);
                        covered = [covered,spktrain(iburst,1):spktrain(iburst,2)];
                        
                        out{itrial,1}(ntop_bursts,:) = [spktimes(top_bursts(ntop_bursts,1)), spktimes(top_bursts(ntop_bursts,2)), top_bursts(ntop_bursts,3)];
                    end
                    
                otherwise
                    if spktrain(iburst,2)<spktrain(1,1) || spktrain(iburst,1)>spktrain(1,2) % this lifts some burden from the loop
                        if isempty(intersect(covered,spktrain(iburst,1):spktrain(iburst,2)))
                            ntop_bursts = ntop_bursts+1;
                            top_bursts(ntop_bursts,:) = spktrain(iburst,:);
                            covered = [covered,spktrain(iburst,1):spktrain(iburst,2)];
                            
                            out{itrial,1}(ntop_bursts,:) = [spktimes(top_bursts(ntop_bursts,1)), spktimes(top_bursts(ntop_bursts,2)), top_bursts(ntop_bursts,3)];
                        end
                    end
            end
            
        end
        
        
        
        % PLOT
        if nargin>2 && pl
            
            hold on
            
            for iburst = 1:size(top_bursts,1)
                % puts markers on each trial (best for numerous trials)
                plot(spktimes(top_bursts(iburst,1)),itrial,'>','color',c(5,:),'markerfacecolor',c(5,:))
                plot(spktimes(top_bursts(iburst,2)),itrial,'<','color',c(2,:),'markerfacecolor',c(2,:))
                
                % puts markers below each trial (best for few trials)
%                 plot(spktimes(top_bursts(iburst,1)),itrial,'>','color',c(5,:))
%                 plot(spktimes(top_bursts(iburst,2)),itrial,'<','color',c(2,:))
                
            end
            
        end
    else
        out{itrial,1} = [];
    end
end


