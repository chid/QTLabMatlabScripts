function qtp(varargin)
% qt plot
    titles = evalin('base', 'titles');
    data   = evalin('base', 'data');
    coordinate = evalin('base', 'coordinate');
    coords = cellfun(@(s)any(strcmp(s,'coordinate')),coordinate);
    num_vals = sum(not(coords));
    num_coords = sum(coords);
    figure
    if num_coords == 1;
        if nargin>0
            n=varargin{1};   
            plot(data(:,1), data(:,n+1));
            xlabel(titles{1});
            ylabel(titles{n+1}); 
        else        
            m=ceil((num_vals)/2);
            for i=1:length(find(coords==0))
                t = find(coords==0);
                n = t(i);
                subplot(m,2,i);
                plot(data(:,1), data(:,n));
                xlabel(titles{1});
                ylabel(titles{n}); 
            end
        end    
    elseif num_coords == 2;
        coord_cols = find(coords==1);
        X = length(find(data(:,1) == data(1,1)));        
        Y = length(find(data(:,2) == data(1,2)));
        x = data(:,1);
        y = data(:,2);        
        if X * Y ~= length(data(:,1))
            % we need to reshape the data
            Y = Y-1;
            x = x(1:(X*Y));
            y = y(1:(X*Y));            
        end
        if nargin>0
            n=varargin{1}; 
            val_cols = find(coords==0);
            z = data(:,val_cols(n));
            pcolor(unique(x), unique(y), reshape(z(1:(X*Y)),X,Y))
            xlabel(titles{coord_cols(1)});
            ylabel(titles{coord_cols(2)});         
            title(titles{val_cols(n)});
        else
            m=ceil((num_vals)/2);
            for n=find(coords==0)';
                j = find(coords==0);
                subplot(m,2,find(j ==n));
                z = data(:,n);                
                pcolor(unique(x), unique(y), reshape(z(1:(X*Y)),X,Y))
                xlabel(titles{1});                
                ylabel(titles{2}); 
                title(titles{n});
                colorbar
                shading flat
            end
        end
        colormap jet
        colorbar
        shading flat
        
    else
        error('unsupported number of coordinates, please contact maintainer.')
    end
        

        

end
