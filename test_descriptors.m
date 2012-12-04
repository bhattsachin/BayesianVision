function peopleset = test_descriptors()
%TEST_DESCRIPTORS Summary of this function goes here
%   Detailed explanation goes here

    SCORE_PATH = 'training/cd/scores';

    %read all input patches and compute score
    peopleset = computeScore(SCORE_PATH);  


    %form a UGM graph and ask for decoding


end


function list_of_files = fetchFileList(SCORE_PATH)
    
    allfiles = dir(SCORE_PATH);
    list_of_files = cell(size(allfiles,1)-3,1);
    for i = 4:size(allfiles,1)
        list_of_files{(i-3)}=allfiles(i).name;
    end


end


function peopleset = computeScore(SCORE_PATH)
    list_of_files = fetchFileList(SCORE_PATH);
    numOfFiles = size(list_of_files,1);
    peopleset = zeros(numOfFiles/9,9,50); %here 50 is word size
    for j=1:numOfFiles
        [~, fname, ext] = fileparts(list_of_files{j});
        len = size(fname,2);
        part = fname(1,len);
        person = fname(1,len-2);
        peopleset(str2double(person),str2double(part),:)=test_codebook(strcat(SCORE_PATH,'/',fname,ext));
    end  


end