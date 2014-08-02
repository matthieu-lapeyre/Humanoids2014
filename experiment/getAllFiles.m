function fileList = getAllFiles(dirName, option)
% Author: http://stackoverflow.com/users/52738/gnovice
% reference: http://stackoverflow.com/questions/2652630/how-to-get-all-files-under-a-specific-directory-in-matlab

  dirData = dir(dirName);      %# Get the data for the current directory
  dirIndex = [dirData.isdir];  %# Find the index for directories
  fileList = {dirData(~dirIndex).name}';  %'# Get a list of the files
  
  
  fileList(ismember(fileList,'.DS_Store')) = [];
  
  % Add option to select only one kind of file
  if nargin>1,
      fileList(cellfun( @(x) isempty(strfind(x, option)), fileList)) = [];
  end
  

  if ~isempty(fileList)
    fileList = cellfun(@(x) fullfile(dirName,x),...  %# Prepend path to files
                       fileList,'UniformOutput',false);
  end
  subDirs = {dirData(dirIndex).name};  %# Get a list of the subdirectories
  validIndex = ~ismember(subDirs,{'.','..'});  %# Find index of subdirectories
                                               %#   that are not '.' or '..'
  for iDir = find(validIndex)                  %# Loop over valid subdirectories
    nextDir = fullfile(dirName,subDirs{iDir});    %# Get the subdirectory path
    fileList = [fileList; getAllFiles(nextDir)];  %# Recursively call getAllFiles
  end

end