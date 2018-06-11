% flying
% this will make a v_Adj with only UAV flights on it
% INPUTS

% OUTPUTS


function [v_AdjNew, distances] = flying(maxDistance, x, y, numPoints, numLevels, v_Cluster, v_ClusterLevel, groupedPoints)

[sNew, tNew, weights, v_AdjNew, distances] =  makingSTWv_Adj(maxDistance, x, y, numPoints, numLevels, v_Cluster, groupedPoints);
numberOfEdges = numel(v_AdjNew);
for i = 1:numberOfEdges
    if v_AdjNew(i) == 0
        v_AdjNew(i) = Inf;
    end
end

numOfTotalPoints = numPoints*numLevels;

for i = 1:numOfTotalPoints
    if v_ClusterLevel(i) == numLevels
        v_AdjNew(:, i) = Inf;
    end
end

end

% TODO: make the flying type of edge only, start with looking at the clusters and how they are working
% TODO: then look at how do I keep track of the distance which the UAV has to fly since each node will be only left to right or right to left
% TODO: Once I know how to keep track of the distance between the two nodes I can fill out the other 4 types of edges
