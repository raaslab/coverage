% specificRuns
% this will run a specific case for if there's an error within "time"
% variable
dbstop error
clc; clear all; close all;
addpath('edgeTypes')
addpath('combos')
data = readData('sampleInput.txt'); % get the size and shape from the data (this will tell you number of clusters points and so on)
[numClusters, ~] = size(data);
x = [data(:,1), data(:,4)];
y = [data(:,2), data(:,5)];
UGVCapable = [data(:,3), data(:,6)];
max_Distance = maxDistance(x, y);
max_Distance = ceil(max_Distance);
max_Distance = 11;   % if max_Distance == j then discharge is unit rate per distance
G = 0;
% x = 0;
% y = 0;
i = numClusters*2; % number of vertices needed to be multiplied by battery levels
j = 11;             % number of battery levels
tTO = 1;           % take off cost
tL = 1;            % landing cost
rRate = 1;         % rate of recharge
UGVS = 1;          % time to travel one unit for the UGV (greater than 1 means UGV is slower)
method = 1;        % 1 = GLNS, 0 = concorde
%     filename = [num2str(i) '_' num2str(j) 'GNLS' num2str(z)];


filename = ['rando1'];
pathName = '/home/klyu/lab/coverageWork/coverage/GTSP';
[ansTime,gtspMatrix,gtspTime, v_Cluster] = testGeneral(i, j, filename, tTO, tL, rRate, UGVS, G, x, y, method, max_Distance, pathName);

% making GLNS matrix input
roundedGtspMatrix = round(gtspMatrix);
roundedGtspMatrix(roundedGtspMatrix == -1) = 999999;
filename = ['/home/klyu/software/GLNS-master-15e0b991963271496d00b5177399961d11857d96/test/rando2.gtsp'];
createGTSPFile(filename,roundedGtspMatrix, i, j, v_Cluster) % creating GLNS file
filename = ['rando3'];
f = fullfile(pathName, filename);
save(f);
