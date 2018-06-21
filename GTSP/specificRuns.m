% specificRuns
% this will run a specific case for if there's an error within "time"
% variable
clc; clear all; close all;
addpath('edgeTypes')
addpath('combos')
data = readData('sampleInput.txt'); % get the size and shape from the data (this will tell you number of clusters points and so on)
[numClusters, ~] = size(data);
x = [data(:,1) data(:,3)]; % check if these are right
y = [data(:,2) data(:,4)];
max_Distance = maxDistance(x, y);
max_Distance = ceil(max_Distance);
G = 0;
% x = 0;
% y = 0;
i = numClusters*2; % number of vertices needed to be multiplied by battery levels
j = 4;             % number of battery levels
tTO = 4;           % take off cost
tL = 4;            % landing cost
rRate = 0;         % rate of recharge
UGVS = 1;          % time to travel one unit for the UGV
method = 1;        % 1 = GLNS, 0 = concorde
%     filename = [num2str(i) '_' num2str(j) 'GNLS' num2str(z)];


filename = ['rando1'];
pathName = '/home/klyu/lab/coverage/GTSP/';
[ansTime,gtspMatrix,gtspTime] = testGeneral(i, j, filename, tTO, tL, rRate, UGVS, G, x, y, method, max_Distance, pathName);



roundedGtspMatrix = round(gtspMatrix);
roundedGtspMatrix(roundedGtspMatrix == -1) = 999999;
filename = ['rando2.gtsp'];
createGTSPFile(filename,roundedGtspMatrix, i, j)
filename = ['rando3'];
f = fullfile(pathName, filename);
save(f);
