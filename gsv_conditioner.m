
function [cnd, time, par, HRrate] = gsv_conditioner(trialList,tar_JT,eyeX,velX,sac)

time.Son = arrayfun(@(x) x.on_time(1), sac);
time.Sof = arrayfun(@(x) x.of_time(1), sac);
time.pv  = arrayfun(@(x) x.pv_time(1), sac);

cnd.Main = trialList(:,11)==1;
cnd.FC   = trialList(:,11)==2;

cnd.STP = (trialList(:,12)-trialList(:,32)) == 0;
cnd.GAP = (trialList(:,12)-trialList(:,32)) == 200;

par.DR = time.Sof - time.Son;
par.RT = time.Son - tar_JT;
par.SK = log2((time.Sof - time.pv) ./ (time.pv - time.Son));

cnd.RS = false(numel(time.Sof),1);
cnd.LS = false(numel(time.Sof),1);

for itrial = 1:length(time.pv)
    
    try
        par.PV(itrial,1) = velX{itrial}(time.pv(itrial));
    catch
        par.PV(itrial,1) = nan;
    end    
    
    try
        par.Xon(itrial,1) = eyeX{itrial}(time.Son(itrial));
    catch
        par.Xon(itrial,1) = nan;
    end
    
    try
        par.Xof(itrial,1) = eyeX{itrial}(time.Sof(itrial));
    catch
        par.Xof(itrial,1) = nan;
    end    
    
    try
        cnd.RS(itrial,1) = eyeX{itrial}(time.Sof(itrial))>0;
        cnd.LS(itrial,1) = eyeX{itrial}(time.Sof(itrial))<0;
    catch
        continue
    end
    
end

par.AM = par.Xof - par.Xon;

cnd.LR = trialList(:,41) == 1;
cnd.HR = trialList(:,41) == 2;

%%

% bin = 10;
% T = 0:10:500;
% [v,~] = histcounts(par.RT,T);
% 
% x = T(2:end) - bin/2;
% ft = fittype('gauss2');
% [model, gof] = fit(x',v',ft);
% par.adjR2 = gof.adjrsquare;
% 
% y = model(1:T(end));
% [~,par.RTth] = findpeaks(-y);
% 
% RTmin = 50;
% cnd.EXP = par.RT>RTmin & par.RT<par.RTth;
% cnd.REG = par.RT>par.RTth;

%%
p = sum(trialList(:,42)==2 & trialList(:,11)==2) ./ sum(trialList(:,11)==2);
HRrate = round(p*1000)/10;


