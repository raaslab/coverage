% typeC
% creates fly, down, up, fly, down, up edge

function [cType] = typeC(FDU, v_Cluster, clusterDirection, distances, levels, sites, clusterLevels, maxDistance, groupedPoints, aEdge, TO, L, RR)

groupedPoints = cell2mat(groupedPoints);
cType = Inf(sites*levels);
for i = 1:(sites*levels)
    for j = 1:(sites*levels)
        firstLeg = [];
        indexOfFirstLeg = [];
        for k = 1:(sites*levels)
            if v_Cluster(i) == v_Cluster(k) && groupedPoints(i) ~= groupedPoints(k)
                firstLeg(end+1) = FDU(i,k);
                indexOfFirstLeg(end+1) = k;
            end
        end
        secondLeg = [];
        for k = 1:length(firstLeg)
            secondLeg(end+1) = FDU(indexOfFirstLeg(k),j);
        end
        bothLegs = firstLeg + secondLeg;
        cType(i,j) = min(bothLegs);
    end
end

for i = 1:(sites*levels)
    for j = 1:(sites*levels)
        if groupedPoints(i) == groupedPoints(j)
            cType(i,j) = Inf;
        end
    end
end

end