% createBaseStationComplex.m
% This adds the base station, but gives costs to go to the base station,
% but not to come from the base station.

function [v_Adj,v_Type] = createBaseStationComplex(v_Adj,numPoints,numLevels,FDU,v_Cluster,groupedPoints,x,y,UGVSpeed,maxDistance,v_Type,F,v_ClusterLevels)


numInV_Adj = numel(v_Adj);
for i = 1:numInV_Adj
    if v_Adj(i) == 0;
        v_Adj(i) = -1;
    end
end

x(end+1) = 0;
y(end+1) = 0;

depotID = (numPoints*numLevels)+1;
groupedPoints = cell2mat(groupedPoints);
v_Cluster = cell2mat(v_Cluster);

for i = 1:(numPoints*numLevels)
    id1 = groupedPoints(i);
    id2 = find((groupedPoints ~= groupedPoints(i)) & (v_Cluster == v_Cluster(i)),1,'last')/numLevels;
    id3 = numPoints+1;
    edgeA = pdist([x(id1),y(id1);x(id2),y(id2)],'euclidean') + pdist([x(id2),y(id2);x(id3),y(id3)],'euclidean'); % F-F
    % check if A is possible
    if edgeA > maxDistance
        edgeA = Inf;
    end
    
    % edgeB and edgeC will never be used because this is the last leg to the depot
    % and there will never be a reason to charge at the depot.
    edgeB = Inf;
    edgeC = Inf;
    
    edgeD = FDU(id1,id2) + pdist([x(id2),y(id2);x(id3),y(id3)],'euclidean');% FDU, F
    % check if D is possible
    if pdist([x(id2),y(id2);x(id3),y(id3)],'euclidean') > maxDistance
        edgeD = Inf;
    end
    
    edgeE = pdist([x(id1),y(id1);x(id2),y(id2)],'euclidean') + (pdist([x(id2),y(id2);x(id3),y(id3)],'euclidean')*UGVSpeed);% F, DTU
    % check if E is possible
    if pdist([x(id1),y(id1);x(id2),y(id2)],'euclidean') > maxDistance % TODO: This needs to take into account the battery level
        edgeE = Inf;
    elseif pdist([x(id1),y(id1);x(id2),y(id2)],'euclidean') > (v_ClusterLevels(i)*(maxDistance/numLevels));
        edgeE = Inf;
    end
    
    [v_Adj(i,depotID), tempID] = min([edgeA,edgeB,edgeC,edgeD,edgeE]); % minimum of all 5 types of edges
    v_Type(i,depotID) = tempID;
end

% adds last row for depot to any site
totalPoints = numPoints*numLevels;
tempCostArray = [];
for i = 1:totalPoints
    if mod(i, numLevels) == 1
        tempCostArray(end+1) = 0;
    else
        tempCostArray(end+1) = -1;
    end
end
tempCostArray(end+1) = -1;
v_Adj(end+1, :) = tempCostArray';

end

