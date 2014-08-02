clear all

input_folder = 'raw_data';
output_folder = 'formatted_data';

measure_type = { 'optilog', 'imulog'};
foot_type = {'foot1','foot1_shoes','foot2','foot2_shoes','foot3','foot4','foot4_shoes',};

        
% Change working directory
copyfile(input_folder, output_folder)
replace_timestamp(output_folder);

for i = 1:numel(foot_type)
    data_path = fullfile(output_folder, foot_type{i}); 
    for j=1:numel(measure_type)
        files_list = getAllFiles(data_path, measure_type{j});

        out.(foot_type{i}).(measure_type{j}) = synchronize_data(files_list);
    end

end

rmdir(output_folder, 's');
save('formatted_data.mat', 'out');
