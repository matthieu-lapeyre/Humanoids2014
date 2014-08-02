function replace_timestamp(folder_name)

files_list = getAllFiles(folder_name);

for i=1:numel(files_list)
    
    filename = files_list{i}
    imported_data = importdata(filename);
    
    % Rewrite the header
    fid = fopen(filename,'r');
    tline = fgetl(fid);
    fclose(fid);
    fid = fopen(filename, 'w');
    fprintf(fid,'%s\n', tline);
    fclose(fid);
    
    % Conversion timestamp/seconds
    if strfind(filename, 'opti')
        val = 1e6;
    else
        val = 1;
    end
    
    imported_data.data = change_time(imported_data.data, val);
    % Remove duplicate timestamp
    [~, idx] = unique(imported_data.data(:,1));
    imported_data.data = imported_data.data(idx,:);
    
    
    
    % Write new data
    dlmwrite(filename, imported_data.data, '-append', 'delimiter','\t');
    
end

end


function data = change_time(data, val)

data(:,1) = (data(:,1)- data(1,1))/val;

end