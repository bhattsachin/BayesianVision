function [optimalDecoding nodeColorPot] = ugm_model(guy)
%UGM_MODEL Summary of this function goes here
%   Detailed explanation goes here

    %from input
    nNodes = 3;

    nStates = 2; %0 or 1 either present or not
    
    adj = whoIsMissing(nNodes, guy);
    
    
    %create edge struct
    edgeStruct = UGM_makeEdgeStruct(adj,nStates);
    
    nodePot = defineNodePot(nNodes,nStates);
    edgeWeight = defineEdgeWeight();
    
    
    maxState = max(edgeStruct.nStates);
    edgePot = zeros(maxState,maxState,edgeStruct.nEdges);

    for e = 1:edgeStruct.nEdges
        edgePot(:,:,e) = defineEdgeWeight(); 
    end
    
    nodeColorPot = defineColorPot(nNodes);
    
    optimalDecoding = UGM_Decode_Exact_One(nodePot,edgePot,edgeStruct, nodeColorPot);


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

