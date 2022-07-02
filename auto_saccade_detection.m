function auto_saccade_detection(pathname)
% auto_saccade_detection(pathname)
% enters the pathname, loads successively already synchronized files and
% detects all saccades per trial. Thise are stored in a structure.
% The first saccade after the first target jump is considered as the
% primary saccade, the saccade directly following as the secondary saccade,
% stored in variables Pri and Sec

if nargin==1
else
    [pathname]=uigetdir('DIRECTORY FOR FILES');
end

eval(['cd ' pathname]);

%detect channel number from foldername
cut  = regexp(pathname,'CH','split');
%%
channel = '1';%%%just for no go_signal files
% channel = cut{2}(1);
% channel = 1;
%sampling rate
Fs = 1000;
   
%do because of old data; if you are redoingthe saccade detection
flistsynctmp = dir(['*.sync.CH' channel '*.mat']); %dir(['*.CH' channel '.corr.*mat']);%
rej = [];
for i=1:length(flistsynctmp)
    if isempty(regexp(flistsynctmp(i).name,'.sync.CH[1-8].mat', 'once') )
        rej = [rej i];
    end
end
flistsynctmp(rej) = [];

%if you have only psychophysics
if isempty(flistsynctmp)
    flistsynctmp = dir('psycho.mat');%dir('*final.mat');
end

flistsync = flistsynctmp;


for i = 1:length(flistsync)

    fprintf([flistsync(i).name '\n']);
    load(flistsync(i).name);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %do the offset removal here
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %to remove a potential target offset
    for h= 1:length(TrialList(:,1))
        if TargetX(1,h) ~= 0
            offx = TargetX(1,h);
            TargetX(:,h) = TargetX(:,h) - offx;
            EyeX(:,h) = EyeX(:,h) - offx;
            offx = [];
        end
        if TargetY(1,h) ~= 0
            offy = TargetY(1,h);
            TargetY(:,h) = TargetY(:,h) - offy;
            EyeY(:,h) = EyeY(:,h) - offy;
            offy = [];
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %because of old data
%     tgtvec = sqrt(TargetX.^2 + TargetY.^2);
%     %just in case a Trial has no target data... however... occurs in Lisas data
%     %-> need to find raw data
%     rej = [];
%     for q = 1: length(tgtvec(1,:))
%     if isempty(find(tgtvec(:,q)~=0,1))
%         rej= [rej q];
%     end
%     end
%     SS=SPKCH5_T1;
%     CS=SPKCH5_T2;
% try TargetX(:,rej) = []; end
% try TargetY(:,rej) = []; end
% try EyeX(:,rej)    = []; end
% try EyeY(:,rej)    = []; end
% try CS(:,rej)      = []; end
% try SS(:,rej)      = []; end
% try TL(:,rej)      = []; end
% try Pri(:,rej)     = []; end
% try Sec(:,rej)     = []; end
% try T3(:,rej)      = []; end
% try T1(:,rej)      = []; end
% try SPK(:,rej)     = []; end
% try LFP(:,rej)     = []; end
% try TrialList(rej,:)      = []; end
%     tgtvec(:,rej)  = [];
%     rej=[];
%     if ~exist('TrialList','var')
%         TrialList = TL;
%         TargetX = TargetX';
%         TargetY = TargetY';
%         EyeX    = EyeX';
%         EyeY    = EyeY';
%     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    x_velocity = zeros (length(EyeX(1,:)),length(EyeX(:,1)));
    y_velocity = zeros (length(EyeY(1,:)),length(EyeY(:,1)));

    for j=1:length(TrialList(:,1))
        x_velocity(j,:)=savgol3(EyeX(:,j),10,3,1,Fs);
        y_velocity(j,:)=savgol3(EyeY(:,j),10,3,1,Fs);
    end
    v_velocity=sqrt(x_velocity.^2+y_velocity.^2);
%     v_velocity = x_velocity;
    
    %allocating variables
    saccade = struct('start',{}, 'end',{}, 'duration',{}, 'v_onset',{}, 'v_end',{}, ...
                     'peak_v',{}, 'average_v',{}, 'amplitude',{});
    Pri = zeros(length(TrialList(:,1)),8);
    Sec = zeros(length(TrialList(:,1)),8);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % calculate targetjump
    for m= 1:length(TrialList(:,1))
        if isempty(find(TargetX(:,m)~=0 | TargetY(:,m)~=0,1))
            tgt_jump(m) = 0;
            warning('found trial without tgt jump');
        else
            tgt_jump(m)   = find(TargetX(:,m)~=0 | TargetY(:,m)~=0,1);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for m= 1:length(TrialList(:,1))
        if isempty(find(abs(TargetX(:,m))==10,1,'last'))
            tgt_jump2(m) = 0;
            warning('found trial without tgt jump');
        else
            tgt_jump2(m)   = find(abs(TargetX(:,m))==10 ,1,'last');
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%
    for j=1:length(TrialList(:,1))
    % try in case anything goes wrong
    try
        saccindexs = 1 + find( v_velocity(j,2:end)>20 & v_velocity(j,1:end-1)<20 );
        saccindexe = 1 + find( v_velocity(j,2:end)<20 & v_velocity(j,1:end-1)>20 );
        
        if (saccindexe(1) < saccindexs(1))
            saccindexe(1) = [];
        end
        if (saccindexs(end) > saccindexe(end))
            saccindexs(end) = [];
        end
        if length(saccindexs) ~= length(saccindexe)
            error('saccade indices not matching');
        end
        
        %reject saccades shorter than 10ms
        tmp = saccindexe - saccindexs;
        saccindexs(tmp<10) = [];
        saccindexe(tmp<10) = [];
        
        %find better saccade on and off set
        for m = 1:length(saccindexs)
            %find saccade start
            for n = 0:29 %go for maximal 30 ms into the past or the future

                %save from running out of array
                if saccindexs(m)-(n+20) <= 1
                    saccindexs(m) = saccindexs(m) - n;
                    break;
                else

                    if v_velocity(j,saccindexs(m)-n) < prctile(v_velocity(j,(saccindexs(m)-n-1):-1:(saccindexs(m)-n-21)) ,95)
                                                       %median(v_velocity(j,saccindexs(m)-n-1:-1:saccindexs(m)-(n+20)) )
                        saccindexs(m) = saccindexs(m) - n;
                        break;
                    end
                end
            end
            %find saccade end
            for o = 0:29

                %save from running out of array into the other direction
                if saccindexe(m)+(o+20) >= length(v_velocity)
                    saccindexe(m) = saccindexe(m) + o;
                    break;
                else

                    if v_velocity(j,saccindexe(m)+o) < prctile(v_velocity(j,(saccindexe(m)+o+1):(saccindexe(m)+o+21)) ,95)
                                                       %prctile(v_velocity(j,saccindexe(m)+o+1:saccindexe(m)+(o+20)) ,99)
                        saccindexe(m) = saccindexe(m) + o;
                        break;
                    end
                end
            end
        end
        
        %calculate values for every detected saccade
        for k = 1:length(saccindexs)
            saccade(j).start(k) = saccindexs(k);
            saccade(j).end(k) = saccindexe(k);
            saccade(j).duration(k) = saccindexe(k)-saccindexs(k); 
            saccade(j).v_onset(k) =  v_velocity(j, saccindexs(k));
            saccade(j).v_end(k) =  v_velocity(j, saccindexe(k));
            saccade(j).peak_v(k) = max(v_velocity(j, saccindexs(k):saccindexe(k)));
            saccade(j).average_v(k) = mean(v_velocity(j, saccindexs(k):saccindexe(k)));
            saccade(j).amplitude(k) = sqrt((EyeX(saccindexe(k), j)-EyeX(saccindexs(k), j))^2 ...
                                     +(EyeY(saccindexe(k), j)-EyeY(saccindexs(k), j))^2);
        end
     
        %if no saccade exists
        if length(saccade(j).start)<1 || length(saccade(j).end)<1
            
            Pri(j, 1:2) = 1;
            Pri(j, 3:8) = 0;
            
        else
        
            %find first saccade after targetjump ms, whose amplitude is
            %bigger than 3 degree
            priindex = find(saccade(j).start > tgt_jump(j) & saccade(j).amplitude > 3 ,1,'first');

            Pri(j,1) = saccade(j).start(priindex);
            Pri(j,2) = saccade(j).end(priindex);
            Pri(j,3) = saccade(j).duration(priindex);
            Pri(j,4) = saccade(j).v_onset(priindex);
            Pri(j,5) = saccade(j).v_end(priindex);
            Pri(j,6) = saccade(j).peak_v(priindex);
            Pri(j,7) = saccade(j).average_v(priindex);
            Pri(j,8) = saccade(j).amplitude(priindex);

            %find second saccade after first saccade
            secindex = find(saccade(j).start > saccade(j).end(priindex),1,'first');

            if ~isempty(secindex)
            
                Sec(j,1) = saccade(j).start(secindex);
                Sec(j,2) = saccade(j).end(secindex);
                Sec(j,3) = saccade(j).duration(secindex);
                Sec(j,4) = saccade(j).v_onset(secindex);
                Sec(j,5) = saccade(j).v_end(secindex);
                Sec(j,6) = saccade(j).peak_v(secindex);
                Sec(j,7) = saccade(j).average_v(secindex);
                Sec(j,8) = saccade(j).amplitude(secindex);
                
            else
                
                Sec(j, 1:2) = 1;
                Sec(j, 3:8) = 0;
                
            end

        end
    
    catch
        
        Pri(j, 1:2) = 1;
        Pri(j, 3:8) = 0;
        Sec(j, 1:2) = 1;
        Sec(j, 3:8) = 0;
        
    end %try
    end


     %saving
    x_velocity = x_velocity';
    y_velocity = y_velocity';
    v_velocity = v_velocity';

    clear j k priindex secindex saccindexs saccindexe
% %     
% % wrongTL= find (Pri(:,1)==1);
% % TrialList(wrongTL,3)=66;
%if you have only psychophysics, else save the whole workspace, can be
%adjusted
if isempty(dir(['*.sync.CH' channel '*.mat']))
    file = [flistsync(i).name '.sacc.mat'];
    file = strrep(file,'.mat.','.');
    TargetX = TargetX';
    TargetY = TargetY';
    EyeX    = EyeX';
    EyeY    = EyeY';
    saccade = saccade';
    if exist('lvl_dur_size','var')
        save(file, 'EyeX','EyeY','TargetX','TargetY','TL','Pri','Sec','saccade','lvl_dur_size','tgt_jump2','tgt_jump');
    else
        save(file, 'EyeX','EyeY','TargetX','TargetY','TL','Pri','Sec','saccade','tgt_jump2','tgt_jump');
    end
else 
    file = [flistsync(i).name '.sacc.mat'];
    file = strrep(file,'experiment','e');
    file = strrep(file,'.mat.','.');
    save(file);
end
    
end

   


end