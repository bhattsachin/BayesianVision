function  [featureCollection pathLength] = study_colordescriptors()
%STUDY_COLORDESCRIPTORS reads some naive cases and
%   Detailed explanation goes here
    [featureCollection pathLength] = filesToMatrix();

end


function [featCollection pathLength]=filesToMatrix()

PATH = 'training/cd/scores';
allfiles = dir(PATH);
featCount = 0;
start = 4;
total = size(allfiles,1);
for i = start:total,
   name = strcat(PATH, '/', allfiles(i).name);
   imgScore = readBinaryDescriptors(strcat(PATH, '/', allfiles(i).name));
   [row, col] = size(imgScore);
   featCount = featCount + row;
end

%initialize the matrix
featCollection = zeros(featCount, col);
pathLength = zeros(total-(start-1),1);
dumbRowCount = 0;

for j = start:total,
   name = strcat(PATH, '/', allfiles(j).name);
   imgScore = readBinaryDescriptors(strcat(PATH, '/', allfiles(j).name));
   [row, ~] = size(imgScore);
   featCollection(dumbRowCount+1:dumbRowCount+row, :) = imgScore;
   dumbRowCount = dumbRowCount+row;
   pathLength(j - (start-1)) = dumbRowCount;
end


end

