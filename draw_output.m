function draw_output(subfolder, targetNode, result)
%DRAW_OUTPUT Summary of this function goes here
    if ~exist(fullfile('training','output',subfolder),'dir')
        mkdir(fullfile('training','output',subfolder));
    end
    close all;

    load(fullfile('training','imgmap',subfolder,'map.mat'),'imgcell','fnamecell');
    sx1 = imgcell(targetNode,2); %x1
    sx2 = imgcell(targetNode,3); %x2
    sy1 = imgcell(targetNode,4); %y1
    sy2 = imgcell(targetNode,5); %y2
    sfile = fnamecell{1,targetNode};  %source of image where above 4 coordinates belong
    
    %draw it, as this is source object, red color boundary
    writefile(sfile,subfolder,sx1,sx2,sy1,sy2,'r');
    
    
    %does scaling helps?? lets see
    
    
    %run a for loop for all values in result and draw each
    nResults = size(result,1);
    for i=1:nResults
       tx1 = imgcell(i,2); %x1
       tx2 = imgcell(i,3); %x2
       ty1 = imgcell(i,4); %x3
       ty2 = imgcell(i,5); %x4
       tfile = fnamecell{1,i}; %this is the source of the image
        
       %draw this too
       if result(i)==1
          %draw this, as we want to draw only those which were detected as
          %matched, green color boundary
          writefile(tfile,subfolder,tx1,tx2,ty1,ty2,'g');
       end
       
    end
    
    %after drawing all the images will be saved to location
    %fullfile('training','output',subfolder,img_file_name_from_source);


end

function writefile(tfile, subfolder, tx1, tx2, ty1, ty2, color)
      
      

      [~, fname, ext] = fileparts(tfile);
      ofile = fullfile('training','output',subfolder,strcat(fname,ext));
      %if file already exists pick it up
      if exist(ofile, 'file')
           im = imread(ofile);
      else
           im = imread(tfile);
      end
      
      
      %scaling
      imsz = size(im);
      % resize so that the image is 300 pixels per inch
      % and 1.2 inches tall
      scale = 1.2 / (imsz(1)/300);
      im = imresize(im, scale, 'method', 'cubic');
      %f = fspecial('gaussian', [3 3], 0.5);
      
      
      

      figure;
      %im = imread(tfile); 
      imshow(im);
      line([tx1 tx1 tx2 tx2 tx1]', [ty1 ty2 ty2 ty1 ty1]', 'color', color, 'linewidth', 2); 
      %out = fullfile('training','output',subdir,strcat(num2str(i),'sample.jpg'));
      export_fig(ofile);


end

