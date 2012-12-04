function train_codebook()
%COLORDIFF Summary of this function goes here
%   Detailed explanation goes here
%allpeople = filesToMatrix();
filesToSingleValueMatrix();
end


function filesToSingleValueMatrix()
%bow
numWords = 80;

%delete the previous training file
disp('Deleting previous model file....');
delete('training/cd/model/model.mat');

PATH = 'training/cd/model';
allfiles = dir(PATH);
total = size(allfiles,1);
%here 384 is for csift

featCount = 0;
for i = 4:total,
   name = strcat(PATH, '/', allfiles(i).name);
   disp(name);
   [tmpNumRows, col] = size(readBinaryDescriptors(strcat(PATH, '/', allfiles(i).name)));
   if(col~=0)
    featCount= featCount + tmpNumRows;
   end
end

featCollection = zeros(featCount, 384);
dumbRowCount = 0;
for i = 4:total,
   name = strcat(PATH, '/', allfiles(i).name);
   imgScore = readBinaryDescriptors(strcat(PATH, '/', allfiles(i).name));
    [row, col] = size(imgScore);
  if (col ~=1)
        featCollection(dumbRowCount+1:dumbRowCount+row, :) = imgScore;
        dumbRowCount = dumbRowCount+row;
    end
    
end

disp('running k means......');
[rawFeat, words] = kmeans(featCollection, numWords);

save('training/cd/model/model.mat','rawFeat','words');



end

