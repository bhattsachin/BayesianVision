function demo()
startup;
display('starting person detector..');

%add current path
%addpath(genpath(pwd));

display('path added');

display('processing raw training files');


%read all files in image folder
PATH = 'training/raw/';
allfiles = dir(PATH);
llc = 0;
for j = 3:size(allfiles,1),
    tmp = llc;
    llc = rawtofine([PATH allfiles(j).name], allfiles(j).name, tmp);
    
end 

end


%detect people in given image
function llc=rawtofine (fname, name, llc)

load('voc-release5/INRIA/inriaperson_final');
model.vis = @() visualizemodel(model, ...
    1:2:length(model.rules{model.start}));
im = imread(fname);
[ds, bs] = imgdetect(im, model, -0.1);
top = nms(ds, 0.1);
llc = show_heads(im,reduceboxes(model, bs(top,:)), strcat('training/fine/', 'f_',name), strcat('training/cd/',name,'.txt'),name, llc);
end

