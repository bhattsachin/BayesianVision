function  [nodeLabels] = UGM_Decode_Exact_One(nodePot, edgePot, edgeStruct, colorPot)
% INPUT
% nodePot(node,class)
% edgePot(class,class,edge) where e is referenced by V,E (must be the same
% between feature engine and inference engine)
%
% OUTPUT
% nodeLabel(node)

UGM_assert(prod(double(edgeStruct.nStates)) < 50000000,'Brute Force Exact Decoding not recommended for models with > 50 000 000 states');
    
nodeLabels = Decode_Exact_One(nodePot,edgePot,edgeStruct, colorPot);

function [nodeLabels] = Decode_Exact_One(nodePot,edgePot,edgeStruct, colorPot)

[nNodes,maxStates] = size(nodePot);
nEdges = size(edgePot,3);
edgeEnds = edgeStruct.edgeEnds;
nStates = edgeStruct.nStates;

% Initialize
y = ones(nNodes,1);

maxPot = -1;
while 1
    
    pot = UGM_ConfigurationPotential_One(y,nodePot,edgePot,edgeEnds, colorPot);

    % Compare against max
    if pot > maxPot
        maxPot = pot;
        nodeLabels = y;
    end

    % Go to next y
    for yInd = 1:nNodes
        y(yInd) = y(yInd) + 1;
        if y(yInd) <= nStates(yInd)
            break;
        else
            y(yInd) = 1;
        end
    end

    % Stop when we are done all y combinations

    if  yInd == nNodes && y(end) == 1
        break;
    end
end

