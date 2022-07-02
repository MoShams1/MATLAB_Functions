function resp = rate_matching_v5(channel1,channel2,start,stop,win_width,win_shift,bin,pl)

win1 = 1;
win2 = floor(1+(stop-win_width-start)/win_shift);

for win= win1:win2
    clear jch1 jch2
    jch1 = sum(channel1.in(:,start+(win-1)*win_shift:start+win_width+(win-1)*win_shift),2);
    jch2 = sum(channel2.in(:,start+(win-1)*win_shift:start+win_width+(win-1)*win_shift),2);
    
    in_resp(win,:,1) = jch1;
    in_resp(win,:,2) = jch2;
    
    geom.in(win) = sqrt(mean(jch1)*mean(jch2));
    
    clear jch1 jch2
    jch1 = sum(channel1.out(:,start+(win-1)*win_shift:start+win_width+(win-1)*win_shift),2);
    jch2 = sum(channel2.out(:,start+(win-1)*win_shift:start+win_width+(win-1)*win_shift),2);
    geom.out(win) = sqrt(mean(jch1)*mean(jch2));
    
    out_resp(win,:,1) = jch1;
    out_resp(win,:,2) = jch2;
    
end

geom.in = round(geom.in*1000000);
geom.out = round(geom.out*1000000);
gg = [geom.in,geom.out];

edge = min(gg):(max(gg)-min(gg))/(bin-1):max(gg);

edge = edge(edge>0);
n = histc(gg,edge);

[n_in,b_in] = histc(geom.in,edge);
[n_out,b_out]= histc(geom.out,edge);

MIN = find(n_in & n_out, 1, 'first');
MAX = find(n_in & n_out, 1, 'last' );

n_final = zeros(1,length(edge));
for i=MIN:MAX
    n_final(i)= min([n_in(i) n_out(i)]);
end

t=0;
resp.in=[];
resp.out=[];

for i=1:length(edge)
    jn = n_final(i);
    
    clear ind1 p1 ind2 p2
    ind_in = find(b_in == i);
    p1 = randperm(length(ind_in),jn);
    
    ind_out = find(b_out == i );
    p2 = randperm(length(ind_out),jn);
    
    for j=1:jn
        t = t+1;
        resp.in(t,:,:)= in_resp(ind_in(p1(j)),:,:);
        resp.out(t,:,:)= out_resp(ind_out(p2(j)),:,:);
    end
    
end

if pl
    subplot(2,1,1)
    if ~isempty(edge)
        bar(edge,n_in,'r')
        hold on
        bar(edge,n_out,'b')
        xlabel('* 0.001 Hz')
        alpha(0.5)
        if exist('n_final','var')
            subplot(2,1,2)
            bar(edge,n_final,'r')
            hold on;
            bar(edge,n_final,'b')
            alpha(0.5)
            xlabel('* 0.001 Hz')
        end
    end
end

end
