function scores = test_cosine_similarity_byparts(peopleset, targetNode, part1, part2 )
%TEST_COSINE_SIMILARITY_BYPARTS 
    %scores = zeros(nNodes,1);
    
    targetPart1 = peopleset(targetNode,part1,:);
    targetPart1 = squeeze(targetPart1(1,1,:));
    
    targetPart2 = peopleset(targetNode,part2,:);
    targetPart2 = squeeze(targetPart2(1,1,:));
    
    scores = cosine_similarity(targetPart1,targetPart2);

end

