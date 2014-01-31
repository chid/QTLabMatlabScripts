function read_data(varargin)
% reads a qtlab ascii text file
    if (nargin>0)
        f = varargin{1};
    else
        [fileselection.filename fileselection.pathname]=uigetfile({'*.dat','*'},'Choose Folder');
        f = [fileselection.pathname fileselection.filename];
        if fileselection.filename == 0
            error('please select a file')    
        end
    end
    newData = importdata(f);
    matches = regexpi(newData.textdata,'#\s*name: (.*)', 'tokens');
    matches = matches(~cellfun('isempty',matches)); % remove empty, could chain these two together
    
    titles = cat(1, matches{:}); % picks out stuff
    newData.titles = titles;

    % Create new variables in the base workspace from those fields.
    vars = fieldnames(newData);
    for i = 1:length(vars)
        assignin('base', vars{i}, newData.(vars{i}));
    end
end