

function [data] = readData(file)

fileID = fopen(file,'r');
% formatSpec = '%f';
formatSpec = '%f %f %f %f';
sizeData = [4 Inf];
data = fscanf(fileID,formatSpec,sizeData);
data = data';
fclose(fileID);
end
