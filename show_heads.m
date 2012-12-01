function llc=show_heads( im, boxes, out, cdout,iname, llc)


%global humanCount;
% Draw bounding boxes on top of an image.
%   showboxes(im, boxes, out)
%
%   If out is given, a pdf of the image is generated (requires export_fig).
klp = 1;

if nargin > 2
  % different settings for producing pdfs
  print = true;
  %wwidth = 2.25;
  %cwidth = 1.25;
  cwidth = 1.4;
  wwidth = cwidth + 1.1;
  imsz = size(im);
  % resize so that the image is 300 pixels per inch
  % and 1.2 inches tall
  scale = 1.2 / (imsz(1)/300);
  im = imresize(im, scale, 'method', 'cubic');
  %f = fspecial('gaussian', [3 3], 0.5);
  %im = imfilter(im, f);
  boxes = (boxes-1)*scale+1;
else
  print = false;
  cwidth = 2;
end

image(im); 
if print
  truesize(gcf);
end
axis image;
axis off;
set(gcf, 'Color', 'white');

[pathstr, flname, ext] = fileparts(iname);

if ~isempty(boxes)
  rows = size(boxes,1);
  
  humans = [(llc+1):(llc+rows)]';
  
  numfilters = floor(size(boxes, 2)/4);
  
  %rows - number of people, columns = 3*number of filters (x,y,radius)
  centroids = zeros(size(boxes,1),numfilters*3);
  k=0;
  if print
    % if printing, increase the contrast around the boxes
    % by printing a white box under each color box
    for i = 1:numfilters
      x1 = boxes(:,1+(i-1)*4);
      y1 = boxes(:,2+(i-1)*4);
      x2 = boxes(:,3+(i-1)*4);
      y2 = boxes(:,4+(i-1)*4);
      k = k+1;
      % remove unused filters
      del = find(((x1 == 0) .* (x2 == 0) .* (y1 == 0) .* (y2 == 0)) == 1);
      x1(del) = [];
      x2(del) = [];
      y1(del) = [];
      y2(del) = [];
      if i == 1
        w = wwidth;
      else
        w = wwidth;
      end
      
      

       %c = 'w' + 1;
       
        centroids(:,(i*3-2):3*i) = [(x2+x1)/2 (y2+y1)/2 ones(rows,1)*10];
        text(floor((x2+x1)/2), floor((y2+y1)/2), num2str(i), 'FontSize', 10, 'color', 'w');
      
       
        for p = 1:floor(rows)
            tp = im(y1(p):y2(p), x1(p):x2(p),:);
            imwrite(tp,strcat('training/tmp/',flname,'_',num2str(p+llc),'_',num2str(i),ext));
            
        end
       
       

        if i==1
        line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', 'r', 'linewidth', w);
        text((floor(x1+x2)/2),(floor(y1+y2)/2), num2str(humans), 'FontSize',30, 'color', 'g'); 
        
        end
        
         if i==4 
        line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', 'b', 'linewidth', w);
        %text((floor(x1+x2)/2),(floor(y1+y2)/2), num2str(klp), 'FontSize',20); 
        
         end
        
         
         if i==7 
        line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', 'b', 'linewidth', w);
        %text((floor(x1+x2)/2),(floor(y1+y2)/2), num2str(klp), 'FontSize',20); 
        
         end
        
           if i==5 
        line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', 'g', 'linewidth', w);
        %text((floor(x1+x2)/2),(floor(y1+y2)/2), num2str(klp), 'FontSize',20); 
        
           end
        
             if i==3 
        line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', 'w', 'linewidth', w);
        %text((floor(x1+x2)/2),(floor(y1+y2)/2), num2str(klp), 'FontSize',20); 
        
             end
          if i==9 
        line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', 'w', 'linewidth', w);
        %text((floor(x1+x2)/2),(floor(y1+y2)/2), num2str(klp), 'FontSize',20); 
        
        end
      
   
    end
  end
  
  llc = llc+rows;
  %write to file
  
  fname = cdout;
  fid = fopen(fname, 'w');
  [rw, col] = size(centroids);
  
  if fid ~= -1
    fprintf(fid,'%s\n','KOEN1');
    fprintf(fid,'24\n'); %this value depends on the descriptor chosen for CD
    fprintf(fid,'%.0f\n',(rw*col)/3);
    
    for r = 1: rw
        
       for c = 1: col
           
           md = mod(c+2,3);
           if md==0
                fprintf(fid,'<CIRCLE '); %start a new line
           end
           
           fprintf(fid,'%.0f ',centroids(r,c));
           
           if md==2
              fprintf(fid,'0 0>;;\n'); 
           end    
           
       end 
    end
    
    
    fclose(fid);
  end
  
  % draw the boxes with the detection window on top (reverse order)

end

% save to pdf
if print
  % requires export_fig from http://www.mathworks.com/matlabcentral/fileexchange/23629-exportfig
  export_fig([out]);
end


