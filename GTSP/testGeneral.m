% testGeneral
% testing of program
% for my own work
% INPUTS
% UGVSpeed = the time to travel one unit for the UGV (has to be greater than equal to 1)
% method = 1 is GLNS, 0 is concorde
% OUTPUTS

% house keeping
% clear all;
% close all;
% clc;


function [time,gtspWeightMatrix2, gtspTime] = testGeneral(numPointsInit, numBatteryLevels, filename, timeTO, timeL, rechargeRate, UGVSpeed, G1, x, y, method, maxDistance, pathName)

time = 0;
rotation = 51; % value used for rotating in graphMakingNew, in degrees
nodeArray = [];

for i = 1:numPointsInit*numBatteryLevels
    nodeArray(end+1) = i;
end
nodeArray = nodeArray';
x1 = reshape(x, 1, [])
y1 = reshape(y, 1, [])
[T, x3d, y3d, z3d] = tableMaking(x1, y1, numBatteryLevels);

% creates 3D plots
h = scatter3(x3d, y3d, z3d);
% creates new graph with existing points
[G2, x2, y2] = graphMakingWPoints(h.XData, h.YData);
[v_Cluster] = makingV_cluster(numPointsInit, numBatteryLevels);
v_Cluster = num2cell(v_Cluster);

[groupedPoints] = makingGroupedPoints(numPointsInit, numBatteryLevels);
groupedPoints = num2cell(groupedPoints);

[v_Adj, v_Type, S1, T1, weights] = makingSTWv_AdjGeneral(maxDistance, x1, y1, numPointsInit, numBatteryLevels, v_Cluster, timeTO, timeL, rechargeRate, UGVSpeed, groupedPoints);

[xOut, yOut] = graphingCluster(x1, y1, numPointsInit, numBatteryLevels, S1, T1, 0, nodeArray, method);            % graph in cluster format

% GTSP solver
tic;
[finalMatrix, G_init, edgeWeightsFinal, finalTour, gtspWeightMatrix, gtspWeightMatrix2] = gtspSolver(v_Cluster, v_Adj, numPointsInit, numBatteryLevels, xOut, yOut, method);
gtspTime = toc;

f = fullfile(pathName, filename);
save(f);
close all;
end

