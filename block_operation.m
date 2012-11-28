function block_operation(img)
    %# find block length in order to get 64 blocks
    imageSize = size(img);
    blockLen = round(imageSize(1:2)/8);

    blocproc(img,blockLen,@average_color)
    fun = @(block_struct) imresize(block_struct.data,img);
    I2 = blockproc(img,blockLen,fun);


end



