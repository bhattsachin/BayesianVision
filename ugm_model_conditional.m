function [optimalDecoding nodeColorPot] = ugm_model_conditional(guy)
%UGM_MODEL Summary of this function goes here
%   Detailed explanation goes here

    %from input
    nNodes = 10;

    nStates = 2; %0 or 1 either present or not
    
    adj = whoIsMissing(nNodes, guy);
    
    
    %create edge struct
    edgeStruct = UGM_makeEdgeStruct(adj,nStates);
    
    nodePot = defineNodePot(nNodes,nStates);
    edgeWeight = defineEdgeWeight();
    
    
    maxState = max(edgeStruct.nStates);
    edgePot = zeros(maxState,maxState,edgeStruct.nEdges);
    
    
    nodeColorPot = defineColorPot(nNodes);

    for e = 1:edgeStruct.nEdges
         n1 = edgeStruct.edgeEnds(e,1);
         n2 = edgeStruct.edgeEnds(e,2);
         similar = UGM_Color_Similarity(nodeColorPot(n1,:,:),nodeColorPot(n2,:,:));
         tmpPot = defineEdgeWeight();
         
         if similar==1
            tmpPot = rot90(tmpPot); %reversed if they are dissimilar 
         end
        
        edgePot(:,:,e) = tmpPot; 
    end
    
    clamped = zeros(nNodes,1);
    clamped(1) = 1;
    
    optimalDecoding = UGM_Decode_Conditional(nodePot,edgePot,edgeStruct, clamped,@UGM_Decode_Exact);


end


function adj = whoIsMissing(nNodes, nodeNumber)

    adj = zeros(nNodes, nNodes);
    for i = 1:nNodes,
       if i~=nodeNumber
          adj(nodeNumber,i)=1; 
       end
    end
    adj = adj + adj';

end


function nodePot = defineNodePot(nNodes, nStates)
    nodePot = ones(nNodes,nStates);
   %initializing to 1
end

function edgePot = defineEdgeWeight()
    %edgePot = zeros(nStates,nStates);
    
    edgePot = [9 1;1 9];
 

end


function colorPot = defineColorPot(nNodes)
    colorPot = zeros(nNodes,9,1) %replace 1 with dimension with final color descriptor feature
    randomPartColor = randi([0,10],[9,1]);
    for i = 1:nNodes,
       randomPartColor = randi([0,10],[9,1]);
       colorPot(i,:,:) =  randomPartColor;
    end

end

