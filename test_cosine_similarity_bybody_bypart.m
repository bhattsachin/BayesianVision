function scores = test_cosine_similarity_bybody_bypart( peopleset, targetNode1, targetNode2, part1, part2 )
%TEST_COSINE_SIMILARITY_BYBODY_BYPART 
    
    targetPart1 = peopleset(targetNode1,part1,:);
    targetPart1 = squeeze(targetPart1(1,1,:));
    
    targetPart2 = peopleset(targetNode2,part2,:);
    targetPart2 = squeeze(targetPart2(1,1,:));
    
    scores = cosine_similarity(targetPart1,targetPart2);
 

end

function scores = is_cosine_similar(peopleset, targetNode1, targetNode2, part1, part2)

    scores = 45;



end

