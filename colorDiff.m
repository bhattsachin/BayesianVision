function [allpeople] = colorDiff(ref)
%COLORDIFF Summary of this function goes here
%   Detailed explanation goes here
%allpeople = filesToMatrix();
allpeople = filesToSingleValueMatrix();

%read all files from scores folder


%convert it back to matrix form


%compute difference with the ref person
refPerson = allpeople(ref,:,:); %boundary check if this index exists
totalPeople = size(allpeople,1);
refMat = repmat(refPerson,totalPeople,1);


%substract everyone with this reference guy
differenceMat = abs(allpeople - refMat);



%find the one with minimum difference




end

function [allpeople]=filesToMatrix()

allpeople = [];
PATH = 'training/cd/scores';
allfiles = dir(PATH);
for i = 3:size(allfiles,1),
   name = strcat(PATH, '/', allfiles(i).name);
   imgScore = readBinaryDescriptors(strcat(PATH, '/', allfiles(i).name));
   [row, col] = size(imgScore);
   personMat = reshape(imgScore, [row/9 9 col]);
   allpeople = [allpeople; personMat];

   
end


      
        
        





end


function bowFeat =filesToSingleValueMatrix()
%bow
numWords = 50;
PATH = 'training/cd/scores';
allfiles = dir(PATH);
total = size(allfiles,1);
everybody = zeros((total-2)/9,9,384); %here 384 is for csift

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
%    imgScore = imgScore/row; 
%    imgScore = sum(imgScore,1);
%    [pathstr, flname, ext] = fileparts(name);
%    len = size(flname,2);
%    part = flname(1,len);
%    person = flname(1,len-2);
%    everybody(str2double(person),str2double(part),:)=imgScore;
    if (col ~=1)
        featCollection(dumbRowCount+1:dumbRowCount+row, :) = imgScore;
        dumbRowCount = dumbRowCount+row;
    end
    
end

[rawFeat, words] = kmeans(featCollection, numWords);
bowFeat = zeros(total-3, numWords);
dumbRowCount = 0;
for i = 4: total
    imgScore = readBinaryDescriptors(strcat(PATH, '/', allfiles(i).name));
    [rows, ~] = size(imgScore);
    tmpRawFeat = rawFeat(dumbRowCount+1:dumbRowCount+rows, :);
    for j=1:numWords
        bowFeat(i, j)=sum(tmpRawFeat==j);
    end
end
bowFeat = bowFeat(4:end, :);
bowFeat = bowFeat./repmat(sum(bowFeat, 2), 1 , numWords);
% bowFeat = zeros(total-3, numWords);
% 
% for i = 4:total,
%    name = strcat(PATH, '/', allfiles(i).name);
%    imgScore = readBinaryDescriptors(strcat(PATH, '/', allfiles(i).name));
%    [tmpRowCount, ~] = size(imgScore);
%    
%    for j = 1:tmpRowCount
%        tmpSim = zeros(numWords, 1);
%        for k = 1:numWords
%            tmpSim(k,:)= (imgScore(j, :)*words(k,:)')/sqrt(sum(imgScore(j, :).^2))/sqrt(sum(words(k, :).^2));
%        end
%        
%        [~, bowFeat(i, j)] = max(tmpSim);
%    end
%        
%     
% end


end

