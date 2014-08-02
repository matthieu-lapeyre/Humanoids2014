function [time, data] = create_data2compare(data_struct, foot_list,data_type, data_zone )

%% Get results
get_data = @(s) s.data(:,:,cellfun( @(x) ~isempty(strfind(x, data_zone)), s.name));

for i=1:numel(foot_list)
    data{i} = get_data(data_struct.(foot_list{i}).(data_type))
    data_time{i} = data_struct.(foot_list{i}).(data_type).time;
    
end


%% Interpolate data for comparaison

duration = min(cellfun(@(t) t(end), data_time));
time_length = max(cellfun(@(t) numel(t), data_time));
n_trial = min(cellfun(@(d) numel(d(1,:,1)), data));

time = linspace(0, duration, time_length);

for i=1:numel(data)
    temp =  arrayfun(@(j) interp1(data_time{i}, data{i}(:,1:n_trial, j), time), [1:numel(data{i}(1,1,:))], 'UniformOutput', 0);
    data{i} = cat(3,temp{:});
end

%% Output
data = cat(3,data{:});
