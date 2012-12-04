function scores = test_cosine_similarity( peopleset, targetNode, part )
%TEST_COSINE_SIMILARITY Summary of this function goes here

    nNodes = size(peopleset,1);
    scores = zeros(nNodes,1);
    targetScore = peopleset(targetNode,part,:);
    targetScore = squeeze(targetScore(1,1,:));


    for i=1:size(peopleset,1)
        tmp = peopleset(i,part,:);
        tmp = squeeze(tmp(1,1,:));
        scores(i) = cosine_similarity(tmp,targetScore);
        
    end



end

