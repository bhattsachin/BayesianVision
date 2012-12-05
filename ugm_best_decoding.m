function [ configuration ] = ugm_best_decoding( peopleset, targetNode )
%UGM_BEST_DECODING returns best decoding based on input
    numberOfPeople = size(peopleset,1);  
    parts = [1, 4, 7, 6, 3, 9];
    nParts = size(parts,2);
    configuration = zeros(numberOfPeople,1);
    
    part = 4;
    
    %UGM vocab - nodes
    nNodes = numberOfPeople; 
    
    nStates = 2; % either present or not
    
    adj = rootNode(nNodes, targetNode);
    
    %create edge struct
    edgeStruct = UGM_makeEdgeStruct(adj,nStates);
    
    nodePot = computeNodePot(nNodes, nStates, peopleset);
     
    edgeWt = computeEdgePot();
    simPot = computeSimilarityPot(nNodes, targetNode, peopleset);
    maxState = max(edgeStruct.nStates);
    edgePot = zeros(maxState,maxState,edgeStruct.nEdges);
    
    for k = 1:nParts
        for e = 1:edgeStruct.nEdges
             n1 = edgeStruct.edgeEnds(e,1);
             n2 = edgeStruct.edgeEnds(e,2);
             similar = is_cosine_similar(peopleset, n1, n2, k, k);
             tmpPot = edgeWt;

             if similar==1
                tmpPot = rot90(tmpPot); %reversed if they are dissimilar 
             end

            edgePot(:,:,e) = tmpPot; 
         end

         clamped = zeros(nNodes,1);
         clamped(targetNode) = 1;

         configuration(:,k) = UGM_Decode_Conditional(nodePot,edgePot,edgeStruct, clamped,@UGM_Decode_Exact);
    end
end



%creates an edge from root node to everyone else
function adj = rootNode(nNodes, nodeNumber)

    adj = zeros(nNodes, nNodes);
    for i = 1:nNodes,
       if i~=nodeNumber
          adj(nodeNumber,i)=1; 
       end
    end
    adj = adj + adj';

end


function nodePot = computeNodePot(nNodes, nStates, peopleset)
    nodePot = ones(nNodes,nStates);
    maxPot = 4; %hardcoding should have learned
    for j=1:nNodes
        nodePot(j,1) = compute_node_potential(peopleset, j);
        nodePot(j,2) = maxPot - nodePot(j,1);
    end

end

function simPot = computeSimilarityPot(nNodes, root, peopleset)
    simPot = zeros(nNodes, 9, 1);
    
    for i=1:nNodes,
        tmpsim = zeros(9,1);
        for j=1:9 %for all parts
            tmpsim(j) = is_cosine_similar(peopleset, root, i, j, j);
            
        end
        simPot(i,:,:)= tmpsim;
    end    

end

%hard coded with the fact that there are only 2 states
function edgePot = computeEdgePot()
    edgePot = [9 1;1 9];
end

