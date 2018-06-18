% making STWGeneral
% this function will make v_Adj with the minimum type of edge between two
% points. There are 3 types of edges that can be use, but are constrained
% by certain properties
% INPUTS
% UGVSpeed = the time to travel one unit for the UGV (has to be greater than equal to 1)
% OUTPUTS

% SUPPRESSING ERRORS
%#ok<*NASGU>


function [v_AdjNew, v_Type, sNew, tNew, weights] = makingSTWv_AdjGeneral(maxDistance, x, y, numPoints, numLevels, v_Cluster, timeTO, timeL, rechargeRate, UGVSpeed, groupedPoints)

v_ClusterLevels = [];
for i = 1:numPoints
    for j = numLevels:-1:1
        v_ClusterLevels(end+1) = j;
    end
end
v_ClusterLevels = v_ClusterLevels';

% create all types of edges
% creating flying edges (only UAV and bat' < bat)
% edge types: These edges are also internal of clusters
[F, allDistances] = flying(maxDistance, x, y, numPoints, numLevels, v_Cluster, v_ClusterLevels, groupedPoints); % fly
% [DUF] = downUpFly(numPoints, numLevels, F, v_Cluster, timeTO, timeL, allDistances, v_ClusterLevels, rechargeRate, UGVSpeed, groupedPoints);
% [DUFDU] = downUpFlyDownUp(); % downUpFlyDownUp
[FDU] = flyDownUp(numPoints, numLevels, F, v_Cluster, timeTO, timeL, allDistances, v_ClusterLevels, rechargeRate, UGVSpeed, groupedPoints); % flyDownUp
[DTU] = downTravelUp(numPoints, numLevels, F, v_Cluster, timeTO, timeL, allDistances, v_ClusterLevels, rechargeRate, UGVSpeed, groupedPoints); % downTravelUp

sizeOfv_Cluster = size(v_Cluster);
tempV_Cluster = cell2mat(v_Cluster);
for i = 1:sizeOfv_Cluster
    if i > sizeOfv_Cluster/2
        tempV_Cluster(i, 2) = 0;
    else
        tempV_Cluster(i, 2) = 1;
    end
end

v_Cluster = tempV_Cluster(:,1);
clusterDirection = tempV_Cluster(:,2);

% make these into functions for each type
% edge type combos: These edges are only external edges
typeAEdge = typeA(F, v_Cluster, clusterDirection, allDistances, numLevels, numPoints, v_ClusterLevels, maxDistance, groupedPoints); % combinations of edge types above
typeBEdge = typeB(F, FDU, v_Cluster, clusterDirection, allDistances, numLevels, numPoints, v_ClusterLevels, maxDistance, groupedPoints);
typeCEdge = typeC(FDU)
typeDEdge = typeD(F, FDU)
typeEEdge = typeE(F, DTU)

% creating charging edges (UAV riding UGV and charging/ bat' >= bat)
% [type2] = makingSTWType2(numPoints, numLevels, type1, v_Cluster, timeTO, timeL, allDistances, v_ClusterLevels, rechargeRate, UGVSpeed);

% creating charge vertex edges (UAV flying to vertex and then charging on UGV at
% vertex/ bat' can be anything compared to bat)
% [type3] = makingSTWType3(numPoints, numLevels, type1, v_Cluster, timeTO, timeL, allDistances, v_ClusterLevels, rechargeRate);

% pick the minimum cost edge here
numOfTotalPoints = numPoints * numLevels;
numberOfEdges = numel(type1);
v_AdjNew(1:numOfTotalPoints, 1:numOfTotalPoints) = Inf;
v_Type(1:numOfTotalPoints, 1:numOfTotalPoints) = 0;

for i = 1:numberOfEdges
    compare = [type1(i), type2(i), type3(i), type4(i), type5(i)]; % array of all types of edge
    [v_AdjNew(i), v_Type(i)]= min(compare);
end

for i = 1:numberOfEdges
    if v_AdjNew(i) == Inf
        v_AdjNew(i) = 0;
        v_Type(i) = 0;
    end
end

sNew = [];
tNew = [];
weights = [];
for i = 1:numOfTotalPoints
    for j = 1:numOfTotalPoints
        if v_AdjNew(i, j) ~= 0
            sNew(end+1) = i;
            tNew(end+1) = j;
            weights(end+1) = v_AdjNew(i, j);
        end
    end
end

end
