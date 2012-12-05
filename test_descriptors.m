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
    numberOfPeople = 0;
    
    %running a dumb loop to get number of people
    for i=1:numOfFiles
       [~, fname, ~] = fileparts(list_of_files{i});
       parsedStr = textscan(fname,'%s','Delimiter','_');
        
       len = size(parsedStr{1},1);
       tmp = parsedStr{1}{len-1};
       
       tmp=str2double(tmp);
       if tmp>numberOfPeople
           numberOfPeople=tmp;
       end 
        
    end     
    
    
    peopleset = zeros(numberOfPeople,9,250); %here 250 is word size
    for j=1:numOfFiles
        [~, fname, ext] = fileparts(list_of_files{j});
        parsedStr = textscan(fname,'%s','Delimiter','_');
        
        len = size(parsedStr{1},1);
        part = parsedStr{1}{len};
        person = parsedStr{1}{len-1};
        peopleset(str2double(person),str2double(part),:)=test_codebook(strcat(SCORE_PATH,'/',fname,ext));
    end  


end