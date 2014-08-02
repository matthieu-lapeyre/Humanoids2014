function change_raw_header(folder_name)

files_list = getAllFiles(folder_name);

for i=1:length(files_list)
%     files_list{i}
    correct_data_header(files_list{i})
end

end


function correct_data_header(filename)

% imu = 'time acc_x acc_y acc_z gyro_x gyro_y gyro_z tilt_x tilt_y tilt_z';
% motor = 'time abs_y-present_position abs_y-goal_position abs_x-present_position abs_x-goal_position abs_z-present_position abs_z-goal_position bust_y-present_position bust_y-goal_position bust_x-present_position bust_x-goal_position head_z-present_position head_z-goal_position head_y-present_position head_y-goal_position l_shoulder_y-present_position l_shoulder_y-goal_position l_shoulder_x-present_position l_shoulder_x-goal_position l_arm_z-present_position l_arm_z-goal_position l_elbow_y-present_position l_elbow_y-goal_position r_shoulder_y-present_position r_shoulder_y-goal_position r_shoulder_x-present_position r_shoulder_x-goal_position r_arm_z-present_position r_arm_z-goal_position r_elbow_y-present_position r_elbow_y-goal_position l_hip_x-present_position l_hip_x-goal_position l_hip_z-present_position l_hip_z-goal_position l_hip_y-present_position l_hip_y-goal_position l_knee_y-present_position l_knee_y-goal_position l_ankle_y-present_position l_ankle_y-goal_position r_hip_x-present_position r_hip_x-goal_position r_hip_z-present_position r_hip_z-goal_position r_hip_y-present_position r_hip_y-goal_position r_knee_y-present_position r_knee_y-goal_position r_ankle_y-present_position r_ankle_y-goal_position';
% optitrack = 'time base_x base_y base_z l_foot_x l_foot_y l_foot_z r_foot_x r_foot_y r_foot_z l_hip_x l_hip_y l_hip_z r_hip_x r_hip_y r_hip_z abs_x abs_y abs_z head_x head_y head_z';

imu ='time\tacc_x\tacc_y\tacc_z\tgyro_x\tgyro_y\tgyro_z\ttilt_x\ttilt_y\ttilt_z';
motor = 'time\tabs_y-present_position\tabs_y-goal_position\tabs_x-present_position\tabs_x-goal_position\tabs_z-present_position\tabs_z-goal_position\tbust_y-present_position\tbust_y-goal_position\tbust_x-present_position\tbust_x-goal_position\thead_z-present_position\thead_z-goal_position\thead_y-present_position\thead_y-goal_position\tl_shoulder_y-present_position\tl_shoulder_y-goal_position\tl_shoulder_x-present_position\tl_shoulder_x-goal_position\tl_arm_z-present_position\tl_arm_z-goal_position\tl_elbow_y-present_position\tl_elbow_y-goal_position\tr_shoulder_y-present_position\tr_shoulder_y-goal_position\tr_shoulder_x-present_position\tr_shoulder_x-goal_position\tr_arm_z-present_position\tr_arm_z-goal_position\tr_elbow_y-present_position\tr_elbow_y-goal_position\tl_hip_x-present_position\tl_hip_x-goal_position\tl_hip_z-present_position\tl_hip_z-goal_position\tl_hip_y-present_position\tl_hip_y-goal_position\tl_knee_y-present_position\tl_knee_y-goal_position\tl_ankle_y-present_position\tl_ankle_y-goal_position\tr_hip_x-present_position\tr_hip_x-goal_position\tr_hip_z-present_position\tr_hip_z-goal_position\tr_hip_y-present_position\tr_hip_y-goal_position\tr_knee_y-present_position\tr_knee_y-goal_position\tr_ankle_y-present_position\tr_ankle_y-goal_position';
optitrack = 'time\tbase_x\tbase_y\tbase_z\tl_foot_x\tl_foot_y\tl_foot_z\tr_foot_x\tr_foot_y\tr_foot_z\tl_hip_x\tl_hip_y\tl_hip_z\tr_hip_x\tr_hip_y\tr_hip_z\tabs_x\tabs_y\tabs_z\thead_x\thead_y\thead_z';

if strfind(filename, 'opti')
    replace_first_line(filename, optitrack);
    
elseif strfind(filename, 'motor')
    replace_first_line(filename, motor);
    
elseif strfind(filename, 'imu')
    replace_first_line(filename, imu);
    
end


end


function replace_first_line(filename, txt)

    imported_data = importdata(filename);
    
    % write the header
    fid = fopen(filename, 'w');
    fprintf(fid, [txt, '\r\n']);
    fclose(fid);
        
    % Write data
    dlmwrite(filename, imported_data.data, '-append', 'precision', '%15.5f','delimiter','\t');


end