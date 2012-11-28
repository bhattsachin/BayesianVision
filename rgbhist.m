function rgbhist(I)
%RGBHIST Summary of this function goes here
%   Detailed explanation goes here
    %RGBHIST   Histogram of RGB values.

    if (size(I, 3) ~= 3)
        error('rgbhist:numberOfSamples', 'Input image must be RGB.')
    end

    nBins = 256;

    rHist = imhist(I(:,:,1), nBins);
    gHist = imhist(I(:,:,2), nBins);
    bHist = imhist(I(:,:,3), nBins);

    hFig = figure;
    hold on;
    h(1) = stem(1:256, rHist);
    h(2) = stem(1:256 + 1/3, gHist);
    h(3) = stem(1:256 + 2/3, bHist);

   % set(h, 'marker', 'none')
    set(h(1), 'Color', [1 0 0])
    set(h(2), 'Color', [0 1 0])
    set(h(3), 'Color', [0 0 1])

end

