myhdl=findall(gca,'Type','surface');
ave=1;
if length(myhdl)==1
cdat=get(myhdl,'CData');
xdat=get(myhdl,'XData');
ydat=get(myhdl,'YData');
% [xxx yyy]=ginput(1);
xxx = 0.1580

yyy = 0.0167
% [xxx yyy]=min((xdat-xxx).^2+(ydat-yyy).^2);
[xxx]=min((xdat-xxx).^2);
[yyy]=min((ydat-yyy).^2);
[aaa bbb]=min(xxx);
xi=bbb;
yi=yyy(bbb);
zzz=aaa;
figure;
plot(xdat(yi,:),cdat(yi,:));
axis tight;

%  hold on
%  [x,y]=ginput(1);
%  figure(hdl);

x=xdat(yi,:)';
y=cdat(yi,:)';
cutdat = [x y];

else

	fprintf(1,'Sorry, could not determine appropriate surface object on current axes!')   

end
