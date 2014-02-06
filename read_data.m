function read_data(varargin)
% reads a qtlab ascii text file
    if (nargin>0)
        f = varargin{1};
    else
        [fileselection.filename fileselection.pathname]=uigetfile({'*.dat','*'},'Choose Folder');
%       should I cd to the path?
        f = [fileselection.pathname fileselection.filename];        
        if fileselection.filename == 0
            error('please select a file')    
        end
    end
    newData = importdata(f);
    matches = regexpi(newData.textdata,'#\s*name: (.*)', 'tokens');
    matches = matches(~cellfun('isempty',matches)); % remove empty, could chain these two together    
    titles = cat(1, matches{:}); % picks out stuff
    
    if strfind(titles{1}{1}, 'Time') > 0
        newData.data(:,1) = newData.data(:,1) / 60 / 60;
        titles{1} = 'Time (Hours)';
        fprintf('Changed Time Axis into Hours\n')
    end
    
    if strfind(titles{2}{1}, 'V_gate') > 0
        newData.data(:,2) = newData.data(:,2) / 5;
        fprintf('Corrected Gate Voltage\n')
    end
    
    matches = regexpi(newData.textdata,'#\s*type: (.*)', 'tokens');
    matches = matches(~cellfun('isempty',matches)); 
    coordinate = cat(1, matches{:}); % picks out stuff
    
    newData.coordinate = coordinate;
    newData.titles = titles;

    % Create new variables in the base workspace from those fields.
    vars = fieldnames(newData);
    for i = 1:length(vars)
        assignin('base', vars{i}, newData.(vars{i}));
    end
    assignin('base', 'filename', fileselection)
    d = cell(0);
    for i=1:size(newData.data,2)
        d{i} = newData.data(:,i);
    end
    assignin('base', 'd', d)
    
    qtp
end