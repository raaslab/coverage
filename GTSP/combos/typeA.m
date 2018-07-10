% typeA
% creates fly, fly edge

% TODO: There is something wrong with the creation of these edges
% Looks like the costs don't match up with the correct node IDs

function [outputEdges] = typeA(F, v_Cluster, clusterDirection, distances, levels, sites, clusterLevels, maxDistance, groupedPoints)

sizeF = size(F);
uniqueClusters = max(unique(v_Cluster));
% for i = 1:
edges = zeros(sites);
for i = 1:sites
    if i > uniqueClusters
        tempFind = (i - uniqueClusters);
        sameCluster = find(v_Cluster == tempFind);
        point2 = sameCluster(levels)/levels;
        point1 = sameCluster(end)/levels;
        costTemp = distances(point1, point2);
        for j = 1:sites
            if point1 == j || point2 == j
                edges(point1, j) = Inf;
            else
                edges(point1, j) = costTemp + distances(point2, j);
            end
        end
    else
        tempFind = i;
        sameCluster = find(v_Cluster == tempFind);
        point2 = sameCluster(levels)/levels;
        point1 = sameCluster(end)/levels;
        costTemp = distances(point1, point2);
        for j = 1:sites
            if point1 == j || point2 == j
                edges(point2, j) = Inf;
            else
                edges(point2, j) = costTemp + distances(point1, j);
            end
        end
    end
end
% for j = 1:sites
%     if j > uniqueClusters
%         tempFind = (j - uniqueClusters);
%         sameCluster = find(v_Cluster == tempFind);
%         point2 = sameCluster(levels)/levels;
%         point1 = sameCluster(end)/levels;
%         costTemp = distances(point1, point2); % cost to go from one side of polygon to other side of polygon
%         for i = 1:sites
%             if point1 == i || point2 == i
%                 edges(point1, i) = Inf;
%             else
%                 edges(point1, i) = costTemp + distances(point1, i);
%             end
%         end
%     else
%         tempFind = j;
%         sameCluster = find(v_Cluster == tempFind);
%         point1 = sameCluster(levels)/levels;
%         point2 = sameCluster(end)/levels;
%         costTemp = distances(point1, point2); % cost to go from one side of polygon to other side of polygon
%         for i = 1:sites
%             if point1 == i || point2 == i
%                 edges(point1, i) = Inf;
%             else
%                 edges(point1, i) = costTemp + distances(point1, i);
%             end
%         end
%     end
%
% end

maxDistancePerLevel = maxDistance/levels;
outputEdges = zeros(sites*levels);
groupedPoints = cell2mat(groupedPoints);
for i = 1:(sites*levels)
    for j = 1:(sites*levels)
        if v_Cluster(i) == v_Cluster(j)
            outputEdges(i,j) = Inf;
        elseif edges(groupedPoints(i),groupedPoints(j)) > maxDistance
            outputEdges(i,j) = Inf;
        else
            numOfLevelsNeeded = ceil(edges(groupedPoints(i),groupedPoints(j))/maxDistancePerLevel);
            if clusterLevels(i) - clusterLevels(j) == numOfLevelsNeeded-1
                outputEdges(i,j) = edges(groupedPoints(i),groupedPoints(j));
            else
                outputEdges(i,j) = Inf;
            end
        end
    end
end
end
