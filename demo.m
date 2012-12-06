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
function [llc imgcell fnamecell] =rawtofine (fname, name, llc, tmpcell, tfnamecell)

load('voc-release5/INRIA/inriaperson_final');
model.vis = @() visualizemodel(model, ...
    1:2:length(model.rules{model.start}));
im = imread(fname);
[ds, bs] = imgdetect(im, model, -0.1);
top = nms(ds, 0.1);
[llc imgcell fnamecell] = show_heads(im,reduceboxes(model, bs(top,:)), strcat('training/fine/', 'f_',name), strcat('training/cd/',name,'.txt'),name, llc,fname,tmpcell, tfnamecell);
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
       imgcell = [];
       fnamecell = cell(0);
       subpath = strcat(PATH,subdir,'/');
       allfilesubdir = dir(subpath);
       %iterate each folder
       for j = 3:size(allfilesubdir,1),
            fname = allfilesubdir(j).name;
            tmp = llc;
            tmpcell = imgcell;
            tfnamecell = fnamecell;
            tf = strcmp(fname,'.DS_Store');
            if ~tf
                disp(strcat(subpath,'/',fname));
                [llc imgcell fnamecell]= rawtofine([subpath fname], fname, tmp, tmpcell, tfnamecell);
            end
       end 
       
       %write imgcell to disk
       if ~exist(fullfile('training','imgmap',subdir),'dir')
          mkdir(fullfile('training','imgmap',subdir));
       end
       
       save(fullfile('training','imgmap',subdir,'map.mat'),'imgcell','fnamecell');  
       
        
    end
    
    

end

