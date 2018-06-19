% typeB
% creates fly, fly, down, up edge

%#ok<*FNDSB>

function [bEdge] = typeB(F, FDU, v_Cluster, clusterDirection, distances, levels, sites, clusterLevels, maxDistance, groupedPoints, aEdge, TO, L, RR)

sizeF = size(F);
uniqueClusters = max(unique(v_Cluster));
% for i = 1:
edges = [];
for j = 1:sites
    if j > uniqueClusters
        tempFind = (j - uniqueClusters);
        sameCluster = find(v_Cluster == tempFind);
        point2 = sameCluster(levels)/levels;
        point1 = sameCluster(end)/levels;
        costTemp = distances(point1, point2); % cost to go from one side of polygon to other side of polygon
        for i = 1:sites
            if point1 == i || point2 == i
                edges(point1, i) = Inf;
            else
                edges(point1, i) = costTemp + distances(point1, i);
            end
        end
    else
        tempFind = j;
        sameCluster = find(v_Cluster == tempFind);
        point1 = sameCluster(levels)/levels;
        point2 = sameCluster(end)/levels;
        costTemp = distances(point1, point2); % cost to go from one side of polygon to other side of polygon
        for i = 1:sites
            if point1 == i || point2 == i
                edges(point1, i) = Inf;
            else
                edges(point1, i) = costTemp + distances(point1, i);
            end
        end
    end
    
end

bEdge =  aEdge;
groupedPoints = cell2mat(groupedPoints);
for i = 1:(sites*levels)
    for j = 1:(sites*levels)
        if v_Cluster(i) == v_Cluster(j)
            bEdge(i,j) = Inf;
        elseif clusterLevels(i) > clusterLevels(j)
            bEdge(i,j) = Inf;
        else
            levelDif = abs(clusterLevels(i) - clusterLevels(j));
            tempPoints = find(groupedPoints == groupedPoints(j));
            minTempPoints = min(bEdge(i,tempPoints));
            bEdge(i,j) = minTempPoints + TO + L + (levelDif*RR);
        end
        
    end
end
% rechargeTime = rRate*(k-lowestLevel)

% maxDistancePerLevel = maxDistance/levels;
% outputEdges = [];
% groupedPoints = cell2mat(groupedPoints);
% for i = 1:(sites*levels)
%     for j = 1:(sites*levels)
%         if v_Cluster(i) == v_Cluster(j)
%             outputEdges(i,j) = Inf;
%         elseif edges(groupedPoints(i),groupedPoints(j)) > maxDistance
%             outputEdges(i,j) = Inf;
%         else
%             numOfLevelsNeeded = ceil(edges(groupedPoints(i),groupedPoints(j))/maxDistancePerLevel);
%             if clusterLevels(i) - clusterLevels(j) == numOfLevelsNeeded-1
%                 outputEdges(i,j) = numOfLevelsNeeded;
%             else
%                 outputEdges(i,j) = Inf;
%             end
%         end
%     end
% end

end