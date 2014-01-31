function qtp(varargin)
% qt plot
    titles = evalin('base', 'titles');
    data   = evalin('base', 'data');
    figure
    if nargin>0
        n=varargin{1};   
        plot(data(:,1), data(:,n+1));
        xlabel(titles{1});
        ylabel(titles{n+1}); 
    else        
        m=ceil((length(titles)-1)/2);
        for n=2:(length(titles));    
            subplot(m,2,n-1);
            plot(data(:,1), data(:,n));
            xlabel(titles{1});
            ylabel(titles{n}); 
        end
    end
end
