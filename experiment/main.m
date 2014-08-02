clear all
close all


load('formatted_data.mat')
data_struct = out;

%% Plot example one foot with multiple data
foot_list = {'foot1'};
data_type = 'optilog';
data_zone = 'head'; % head_x, head_y, head_z

[time, data] = create_data2compare(data_struct, foot_list, data_type, data_zone );

plot_mean_std(data, time)

return
%% Plot example multiple foot with one data
data_struct = out;
foot_list = {'foot1', 'foot2', 'foot3'};
data_type = 'optilog';
data_zone = 'head_x';

[time, data] = create_data2compare(data_struct, foot_list, data_type, data_zone );

plot_mean95_std(data, time)
