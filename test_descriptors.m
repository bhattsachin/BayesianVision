function peopleset = test_descriptors(person)
%TEST_DESCRIPTORS Summary of this function goes here
%   Detailed explanation goes here

    SCORE_PATH = 'training/cd/scores';
    
    dude = person; %this must come from input, we are searching for him
    
    %delete previous output
    rmdir(fullfile('training','output'),'s');
    mkdir(fullfile('training','output'));
    
    list_of_files = fetchFileList(SCORE_PATH);
    numOfFiles = size(list_of_files,1);
    
    for i=1:numOfFiles
    
        %read all input patches and compute score
        peopleset = computeScore(strcat(SCORE_PATH,'/',list_of_files{i}));  


        %form a UGM graph and ask for decoding
        configuration = ugm_best_decoding(peopleset, dude);
        
        %sum all 1's
        configrows = max(sum(configuration == 1, 2), 1);
        %make the source value zero
        configrows(dude, :)=0;
        
        %only the matched objects have value 1
        configrows = configrows==max(configrows);
        
        
        
        
        draw_output(list_of_files{i},dude, configrows);
    end

end


function list_of_files = fetchFileList(SCORE_PATH)
    
    allfiles = dir(SCORE_PATH);
    list_of_files = cell(size(allfiles,1)-2,1);
    for i = 3:size(allfiles,1)
        list_of_files{(i-2)}=allfiles(i).name;
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
    
    
    peopleset = zeros(numberOfPeople,9,500); %here 500 is word size
    for j=1:numOfFiles
        [~, fname, ext] = fileparts(list_of_files{j});
        parsedStr = textscan(fname,'%s','Delimiter','_');
        
        len = size(parsedStr{1},1);
        part = parsedStr{1}{len};
        person = parsedStr{1}{len-1};
        peopleset(str2double(person),str2double(part),:)=test_codebook(strcat(SCORE_PATH,'/',fname,ext));
    end  


end