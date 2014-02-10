% let's look at the last one
% figure(6)
onpeak = cell(0)
for i=1:(length(ii)-1)
    figure(i)
    hold off
    f = ii(i)
    f = f+1
    e = ii(i+1)
    e = e-1

    t = d{2}; % gate
    I = d{3};
    subplot(2,1,1)
    plot(d{1}(f:e),d{3}(f:e))
    subplot(2,1,2)
    plot(d{1}(f:e),d{2}(f:e))

    I_s = sort(I(f:e));
    I_thresh = I_s(floor(length(I_s)/2))
    
%     this is bugged, but I have implemented a bad fix.
    tmp = find(I > I_thresh);
    tt = find(tmp > f);
    first = tmp(tt(1))
    
    subplot(2,1,1)
    hold on
    plot(d{1}(first:e),d{3}(first:e),'r.')
    subplot(2,1,2)
    hold on
    plot(d{1}(first:e),d{2}(first:e),'r.')
    onpeak{i} = d{2}(first:e)
end