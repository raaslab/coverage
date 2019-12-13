% making STWGeneral
% this function will make v_Adj with the minimum type of edge between two
% points. There are 3 types of edges that can be use, but are constrained
% by certain properties
% INPUTS
% UGVSpeed = the time to travel one unit for the UGV (has to be greater than equal to 1)
% OUTPUTS

function [v_AdjNew, v_Type, sNew, tNew, weights, v_ClusterLevels, FDU,M] = makingSTWv_AdjGeneral(maxDistance, x, y, numPoints, numLevels, v_Cluster, timeTO, timeL, rechargeRate, UGVSpeed, groupedPoints,UGVCapable,fixedRatio,turnRadius)

v_ClusterLevels = Inf([1, numPoints*numLevels]);
counter = 1;
for i = 1:numPoints
    for j = numLevels:-1:1
        v_ClusterLevels(counter) = j;
        counter = counter+1;
    end
end
v_ClusterLevels = v_ClusterLevels';

v_UGVCapable = Inf([1, numPoints*numLevels]);
counter = 1;
for i = 1:numPoints
    for j = 1:numLevels
        v_UGVCapable(counter) = UGVCapable(i);
        counter = counter+1;
    end
end
v_UGVCapable = v_UGVCapable';

% create all types of edges
% creating flying edges (only UAV and bat' < bat)
% edge types: These edges are also internal of clusters
[M, allDistancesM] = flyingM(maxDistance, x, y, numPoints, numLevels, v_Cluster, v_ClusterLevels, groupedPoints); % fly multi-rotor
[F, allDistancesF] = flyingF(maxDistance, x, y, numPoints, numLevels, v_Cluster, v_ClusterLevels, groupedPoints,fixedRatio,turnRadius); % fly fixed-wing
[FDUM] = flyDownUpM(numPoints, numLevels, M, v_Cluster, timeTO, timeL, allDistancesM, v_ClusterLevels, rechargeRate, UGVSpeed, groupedPoints, maxDistance); % flyDownUp mutli-rotor
[FDUF] = flyDownUpF(numPoints, numLevels, F, v_Cluster, timeTO, timeL, allDistancesF, v_ClusterLevels, rechargeRate, UGVSpeed, groupedPoints, maxDistance); % flyDownUp fixed-wing
[DTU] = downTravelUp(numPoints, numLevels, M, v_Cluster, timeTO, timeL, allDistancesM, v_ClusterLevels, rechargeRate, UGVSpeed, groupedPoints); % downTravelUp

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

FDUMNew = checkUGVPossibility(FDUM,v_UGVCapable,1);
FDUFNew = checkUGVPossibility(FDUF,v_UGVCapable,1);
DTUNew = checkUGVPossibility(DTU,v_UGVCapable,2);

% make these into functions for each type of edge combo
% edge type combos: These edges are only external edges and the combination of the above edges
% TODO: make all the combination edges possible
typeAEdge = typeA(v_Cluster, allDistances, numLevels, numPoints, v_ClusterLevels, maxDistance, groupedPoints); % F, F
typeBEdge = typeB(M, FDUNew, v_Cluster, allDistances, numLevels, numPoints, groupedPoints, typeAEdge, timeTO, timeL, rechargeRate); % F, FDU
typeCEdge = typeC(FDUNew, v_Cluster, numLevels, numPoints, groupedPoints, typeAEdge, timeTO, timeL, rechargeRate); % FDU, FDU
typeDEdge = typeD(M, FDUNew, v_Cluster, numLevels, numPoints, groupedPoints, typeAEdge, timeTO, timeL, rechargeRate); % FDU, F
typeEEdge = typeE(M, DTUNew, v_Cluster, allDistances, numLevels, numPoints, groupedPoints, typeAEdge, timeTO, timeL, rechargeRate); % F, DTU
Aedge = edgeA(v_Cluster, allDistances, numLevels, numPoints, v_ClusterLevels, maxDistance, groupedPoints); % MMM
% Bedge = edgeB(); % MMF
Cedge = edgeC(); % MGM
% Dedge = edgeD(); % MGF
Eedge = edgeE(); % MFM
% Fedge = edgeF(); % MFF
Gedge = edgeG(); % FMM
% Hedge = edgeH(); % FMF
Iedge = edgeI(); % FGM
% Jedge = edgeJ(); % FGF
Kedge = edgeK(); % FFM
% Ledge = edgeL(); % FFF

% pick the minimum cost edge here
numOfTotalPoints = numPoints * numLevels;
numberOfEdges = numel(typeAEdge);
v_AdjNew(1:numOfTotalPoints, 1:numOfTotalPoints) = Inf;
v_Type(1:numOfTotalPoints, 1:numOfTotalPoints) = 0;

for i = 1:numberOfEdges
    compare = [typeAEdge(i),typeBEdge(i),typeCEdge(i),typeDEdge(i),typeEEdge(i)]; % array of all types of edge
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
