figure(1)
clf('reset')
hl1 = line(data(:,1),data(:,2), 'Color','r');
ax1 = gca;
set(ax1,'XColor','r','YColor','r')


ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');
% line(x2,y2,'Color','k','Parent',ax2);
hl2 = line(data(:,1),-data(:,5) * .1, 'Color','k' ,'Parent',ax2)