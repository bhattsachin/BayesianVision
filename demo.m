function demo()
startup;
display('starting person detector..');

%add current path
%addpath(genpath(pwd));

display('path added');

display('processing raw training files');

%delete all the files first
deleteTmpFolder(); 

%read all files in image folder
PATH = 'training/raw/';

dir_iterate(PATH);

% allfiles = dir(PATH);
% llc = 0;
% for j = 3:size(allfiles,1),
%     tmp = llc;
%     name = allfiles(j).name;
%     tf = strcmp(name,'.DS_Store');
%     if ~tf
%         llc = rawtofine([PATH allfiles(j).name], allfiles(j).name, tmp);
%     end
% end 

end


%detect people in given image
function llc=rawtofine (fname, name, llc)

load('voc-release5/INRIA/inriaperson_final');
model.vis = @() visualizemodel(model, ...
    1:2:length(model.rules{model.start}));
im = imread(fname);
[ds, bs] = imgdetect(im, model, -0.1);
top = nms(ds, 0.1);
llc = show_heads(im,reduceboxes(model, bs(top,:)), strcat('training/fine/', 'f_',name), strcat('training/cd/',name,'.txt'),name, llc,fname);
end

function deleteTmpFolder()

PATH = 'training/tmp';
allfiles = dir(PATH);
dirids = [allfiles.isdir];
alldirs = allfiles(dirids);
allnondir = allfiles(~dirids);


    for j=1:size(allnondir,1)
       delete(strcat(PATH,'/',allnondir(j).name));
    end
    
    for j=3:size(alldirs,1)
        rmdir(strcat(PATH,'/',alldirs(j).name),'s');
    end
end

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
       llc = 0;
       subpath = strcat(PATH,subdir,'/');
       allfilesubdir = dir(subpath);
       %iterate each folder
       for j = 3:size(allfilesubdir,1),
            fname = allfilesubdir(j).name;
            tmp = llc;
            tf = strcmp(fname,'.DS_Store');
            if ~tf
                disp(strcat(subpath,'/',fname));
                llc = rawtofine([subpath fname], fname, tmp);
            end
       end 
       
        
    end
    
    

end

