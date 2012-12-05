function similar = is_cosine_similar( peopleset, targetNode1, targetNode2, part1, part2 )
%IS COSINE_SIMILAR 
    similar = 0; %similar
    


    score = test_cosine_similarity_bybody_bypart(peopleset, targetNode1, targetNode2, part1, part2);

    if (score<0.3) %this is the threshold, must not be hard coded
       similar = 1;
    end
    
    
end

