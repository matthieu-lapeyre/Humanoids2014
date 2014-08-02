function s = synchronize_data(files_list)

%% Compute the vector lenght
exp_elem = [];
exp_time = [];


for i=1:numel(files_list)
    
    out = importdata(files_list{i});
    

    if strfind(files_list{i}, 'opti')
        out.data = replace_wrong_value(out.data);
    end

    data{i} = out.data;
    exp_elem = [exp_elem, numel(out.data(:,1))];
    exp_time = [exp_time, out.data(end,1)];
    
end

data_length = ceil(max(exp_elem)/100)*100;
data_time = floor(min(exp_time)*10)/10;



%% Interpolate the data

time = linspace(0, data_time, data_length);


data_interp = cellfun(@(d) interp1(d(:,1), d(:,2:end), time), data, 'UniformOutput', 0);
data_interp = cat(3,data_interp{:});



%% shift data
data_interp = data_interp - repmat(data_interp(1,:,:),[data_length,1,1]);

%% Output structure

s.time = time;
s.data = permute(data_interp,[1,3,2]);
s.name = {out.colheaders{2:end}};


end


function data = replace_wrong_value(data)

n_column = numel(data(1,2:end));
time = data(:,1);
data = data(:,2:end);

data = cell2mat(arrayfun(@(i) interp1(time(data(:,i)<9999), data(data(:,i)<9999,i), time), [1:n_column],'UniformOutput',0));

data(isnan(data)) = 0.0;

data = [time, data];

end