% typeA
% creates fly, fly edge

function [edges] = typeA(F, v_Cluster, clusterDirection, distances, levels, sites)
% create all possible fly edges and their costs
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

% TODO: create correct adjacancy matrix for the battery level drops.
end
