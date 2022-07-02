function SD = Spike_Density(cell_act, delta, filt_size, maxtrial)

if (filt_size/2)==floor(filt_size/2)
    filt_size=filt_size+1;
end

filter=gaussian(ceil(filt_size/2), delta, 1:filt_size);
for i=1:maxtrial
    temp=conv(cell_act(i,:), filter);
    SD(i,:)=temp((filt_size-1)/2+1:length(temp)-(filt_size-1)/2);
end

SD=1000*SD;   %converted to spikes/s (see Richmond et al. 1987)