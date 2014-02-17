function re = qt_fft(t,x)
    t = t * 3600;
    time = max(t) - min(t);
%     frequency is number of points divided by time    
    figure;
    % we take y as time in hours
    Fs = length(t) / time;
    [psdestx,Fxx] = periodogram(x,rectwin(length(x)),length(x),Fs);
%     plot(Fxx,psdestx); grid on;
    loglog(Fxx,psdestx); grid on;
    xlabel('Hz'); ylabel('Power/Frequency (V^2/Hz)');
    title('Periodogram Power Spectral Density Estimate');    
    re = {psdestx,Fxx};
end