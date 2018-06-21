% typeE
% creates fly, down, travel, up edge

function [eType] = typeE(F, DTU, v_Cluster, clusterDirection, distances, levels, sites, clusterLevels, maxDistance, groupedPoints, aEdge, TO, L, RR)



groupedPoints = cell2mat(groupedPoints);
eType = Inf(sites*levels);
for i = 1:(sites*levels)
    %     thisCluster = v_Cluster(i);
    %     allThisCluster = find(v_Cluster == thisCluster);
    for j = 1:(sites*levels)
        firstLeg = [];
        indexOfFirstLeg = [];
        for k = 1:(sites*levels)
            if v_Cluster(i) == v_Cluster(k) && groupedPoints(i) ~= groupedPoints(k)
                firstLeg(end+1) = F(i,k);
                indexOfFirstLeg(end+1) = k;
            end
        end
        secondLeg = [];
        for k = 1:length(firstLeg)
            secondLeg(end+1) = DTU(indexOfFirstLeg(k),j);
        end
        bothLegs = firstLeg + secondLeg;
        eType(i,j) = min(bothLegs);
    end
end


end