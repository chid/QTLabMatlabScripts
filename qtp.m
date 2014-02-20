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
%                 plot(data(:,2), data(:,n));
                plot(data(:,1), data(:,n));
                xlabel(titles{1});
                ylabel(titles{n}); 
%                 xlabel 'V_{GSET}'               
            end
            
%             subplot(m,2,1);
%             hold all
%             for i=unique(data(:,5))'
%                i
%                x = data(:,1);
%                y = data(:,2);
%                index = find(data(:,5) == i);
%                plot(x(index),y(index))
%             end
%             subplot(m,2,2);
%             hold all
%             for i=unique(data(:,5))'               
%                x = data(:,1);
%                y = data(:,3);
%                index = find(data(:,5) == i);
%                plot(x(index),y(index))
%             end
%             hold off
                
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
%             m = 1
            for n=find(coords==0)';
                j = find(coords==0);
                if (num_vals > 1)
                    subplot(m,2,find(j ==n));
                else
                    subplot(1,1,find(j ==n));
                end
                z = data(:,n);
                [~,i] = unique(x); x = x(sort(i));
                [~,i] = unique(y); y = y(sort(i));                
                pcolor(x, y, reshape(z(1:(X*Y)),X,Y))
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
    filename = evalin('base', 'filename');
    suptitle(regexprep(filename.filename,'_','\\_'))

        

end
