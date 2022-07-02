% aligntrials 1.0
% first version:        2018.02
% last modification:    2022.03.23
% Mohammad Shams
% m.shamsahmar@gmail.com
% --------------------------

% M = aligntrials(C,alignVec,pre,post,report)
% C: input cell {trial}(time) or numeric matrix (trial x time)
% alignVec: time-points for alignment in each trial
% pre: time-window preceding the alignment time-point
% post: time-window proceding the alignment time-point
% report: report which trials were problematic
% M: output matrix (trial x time)

function M = aligntrials(C,alignVec,pre,post,report)

if isnumeric(C)
    C = num2cell(C,2);
end

if iscell(C)
    M = nan(numel(C),pre+post+1);
    nan_train = zeros(numel(C),1);
    for iTrial = 1:numel(C)
        try
            M(iTrial,:) = C{iTrial}(alignVec(iTrial)-pre:alignVec(iTrial)+post);
        catch
            nan_train(iTrial) = 1;
        end
    end
    
    nan_trials = find(nan_train)';
    if report && ~isempty(nan_trials)
        fprintf('NaN filled rows in the output matrix:')
        display(nan_trials)
        warning([num2str(length(nan_trials)/iTrial*100),'% were not included!'])
    end
    
else
    error('First input must be either numeric or cell type.')
   
end