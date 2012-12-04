function flatFeat = test_codebook(filename)
%TEST_CODEBOOK Summary of this function goes here

%read codebook and load
book = load('training/cd/model/model.mat');
words = book.words;
[numWords, ~] = size(words);
flatFeat = zeros(numWords,1);

%read given descriptor file
descriptor = readBinaryDescriptors(filename);
[row, col] = size(descriptor);

if(col~=1)
    %file is not corrupt
    bowFeat = zeros(row,1);

    for i=1:row
        sim = zeros(numWords, 1);
        for k = 1:numWords
            sim(k,:)= (descriptor(i, :)*words(k,:)')/sqrt(sum(descriptor(i, :).^2))/sqrt(sum(words(k, :).^2));
        end
        [~, bowFeat(i)] = max(sim); %will assign most closest match
    end 
    

    for i=1:numWords
           flatFeat(i) = sum(bowFeat==i);
    end
    
    %normalize it
    flatFeat = flatFeat/row;
    
    
end

end

