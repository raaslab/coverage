% typeC
% creates fly, down, up, fly, down, up edge

function [edge] = typeC(FDU, v_Cluster, clusterDirection, distances, levels, sites, clusterLevels, maxDistance, groupedPoints, aEdge, TO, L, RR)

groupedPoints = cell2mat(groupedPoints);
cType = Inf(sites*levels);
for i = 1:(sites*levels)
    for j = 1:(sites*levels)
        if v_Cluster(i) == v_Cluster(j) && groupedPoints(i) ~= groupedPoints(j)
%             for k = 1:levels % change this so it's only looking at the intermediate steps (subset of i)
               cost1 = FDU(i,j)
                tempPoints = find(groupedPoints(j)==groupedPoints)
                cType(i,j) = FDU(i,j) + FDU(i,j);
%             end
        end
    end
end

end