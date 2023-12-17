function fileList = GetImages(directory)
  data = dir(directory);      %# Get the data for the current directory
  dirIndex = [data.isdir];  %# Find the index for directories
  fileList = {data(~dirIndex).name}';  %'# Get a list of the files
  fileList = fullfile(directory, ...
    fileList);
end