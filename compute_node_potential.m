function [ potential] = compute_node_potential(peopleset, dude )
%COMPUTE_NODE_POTENTIAL Summary of this function goes here
    potential = 1;
    
    root = peopleset(dude,1,:); %root part
    root = squeeze(root(1,1,:));
    
    elements = [4, 7, 6, 3, 9];
    
    
    for j=1:size(elements,2)
        %match with left upper body
        part = peopleset(dude,elements(j),:);
        part = squeeze(part(1,1,:)); 
        score = cosine_similarity(root,part);
        if isnan(score)
           score = 0;
        end
        potential = potential + score;
    end
    
   

end

