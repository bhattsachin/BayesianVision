function similar= UGM_Color_Similarity(parts1, parts2)
%UGM_COLOR_SIMILARITY Summary of this function goes here
%   Detailed explanation goes here

    % 0 refers to true value
    %similar = 0;
    
    %checking for only one part - part 4
    similar = isInsideThreshold(parts1(4), parts2(4));
    
    

end


function inrange = isInsideThreshold(val1 , val2)

    inrange = 0;
    threshold = 2;
    [row col] = size(val1); %size of color descriptor vector
    threshVector = ones(row, col)*threshold;
    zeroVector = zeros(row, col);
    
    
    diff = abs(val1-val2);
    
    if (diff>threshVector)==zeroVector,
        inrange = 0;
    else
        inrange = 1;
    end
    

end

