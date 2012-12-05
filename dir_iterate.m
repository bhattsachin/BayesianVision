function dir_iterate( directory )
%DIR_ITERATE iterate a given directory
    PATH = directory;
    allfiles = dir(directory);
    dirids = [allfiles.isdir];
    alldirs = allfiles(dirids);
    allnondir = allfiles(~dirids);
    
    for i=3:length(alldirs)
       subdir = alldirs(i).name;
       disp(subdir); 
       subpath = strcat(PATH,'/',subdir);
       allfilesubdir = dir(subpath);
       %iterate each folder
       for j = 3:size(allfilesubdir,1),
            fname = allfilesubdir(j).name;
            tf = strcmp(fname,'.DS_Store');
            if ~tf
                disp(strcat(subpath,'/',fname));
                %llc = rawtofine([subpath fname], fname, tmp);
            end
       end 
       
        
    end
    
    

end

