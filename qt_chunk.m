% chunks data based off the fifth column. my 'nothing' column

x = d{5};

% [X, SortVec] = sort(x);
X = x;
%Remove duplicates
% UV(SortVec) = ([1; diff(X)] ~= 0);
ii = find([1; diff(X)] ~= 0);
iii = find([0; diff(ii)] ~= 1 & [0; diff(ii)] ~= 2);
ii = ii(iii);
ii = [ii;length(x)];
%Resort to be back in original order
y = x(ii);
% y
% find(UV ~= 0)

% ii is where we chunk at.
close all
% figure

for i=2:length(ii)
% for i = 4
    f = ii(i-1);
    f = f + 1; % FIX THIS
    e = ii(i);   
%     subplot(2,5,i-1)    
    h = figure;
%     title_s = {'#1 (Gate Pulse) .75V (Nothing)', '#2 (Gate Pulse) .75V (2sec)', '#3 (Gate Pulse) .75V (20sec)'};
    title_s = {'#1 (Gate Pulse) .-5V (Nothing)', ...
        '#2 (Gate Pulse) -.5V (2sec)', ...
        '#3 (Gate Pulse) -.5V (20sec)'};
    for j=2:4
        subplot(3,1,j-1)
        plot(d{1}(f:e),d{j}(f:e))
        xlabel(titles{1})
        ylabel(titles{j})
        annotation('textbox', [.90, 0.2, 0, 0], 'string', ...
            'Lock In Amp 80\muV, Jump: 0.3mV, Proportional Max: .4pA, LockInThreshold: .5e-13 A')
%           'Lock In Amp 2mV, Jump: 1.5mV, Proportional Max: 11pA, LockInThreshold: .5e-13 A')
        
        
        if (f > 1)    
            suptitle(sprintf('#%i (Gate Jumps) %s V to %s V',i-1,num2str(x(f-1)),num2str(x(f))))
        else
            suptitle(sprintf('#%i (Gate Jumps) %sV',i-1,num2str(x(f))))
        end
%         suptitle(title_s{i-1})
        if (i > 2)
%             Vs = [0.5, 1];
%             Ds = [2, 20];
            Vs = [.5, 1];
            Ds = [2, 20];
%             ceil((i-1)/2)
%             mod(i-1,2) + 1
            suptitle(sprintf('#%i (Gate Pulse) %.1f V for %i seconds\n',i-1,Vs(ceil((i-2)/2)), Ds(mod(i-1,2) + 1)))
        %     fprintf('%.1f V for %i seconds\n',Vs(ceil(i/2)), Ds(mod(i-1,2) + 1))
        else
            suptitle(sprintf('#1 (Gate Pulse) (none)\n'))
        end

        
    end
%     title(sprintf('#%i %s to %f',i-1,num2str(x(f)),x(e)))
    
    print('-depsc','-tiff','-r300',num2str(i))
    
end