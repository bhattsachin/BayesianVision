function [pot] = UGM_ConfigurationPotential_One(y,nodePot,edgePot,edgeEnds, colorPot)
% [pot] = UGM_ConfigurationPotential(y,nodePot,edgePot,edgeEnds)
nNodes = size(nodePot,1);
nEdges = size(edgeEnds,1);

pot = 1;

% Nodes
for n = 1:nNodes
   pot = pot*nodePot(n,y(n));
end


% Edges
for e = 1:nEdges
   n1 = edgeEnds(e,1);
   n2 = edgeEnds(e,2);
   similar = UGM_Color_Similarity(colorPot(n1,:,:),colorPot(n2,:,:));
   tmpPot = edgePot(:,:,1); %as all are symmetric
   if similar==1
       tmpPot = rot90(tmpPot); %reversed if they are dissimilar 
   end
   
   pot = pot*tmpPot(y(n1),y(n2)); 
end

