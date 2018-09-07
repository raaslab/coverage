% specificRuns
% this will run a specific case for if there's an error within "time"
% variable
dbstop error
clc; clear all; close all;

trial = 2;
numBC = 10;

% filename4 = sprintf('inputs/fieldExperiments/fieldExperiment%d.txt',trial);
% polygonCreater(filename4,numBC,100,0,0) % creates random polygons.

% use 'testInput.txt' if you want the file from polygonCreater
data = readData('inputs/fieldExperiments/kentLand2.txt'); % get the size and shape from the data (this will tell you number of clusters points and so on)
[numClusters, ~] = size(data);
x = [data(:,1), data(:,4)];
y = [data(:,2), data(:,5)];
UGVCapable = [data(:,3), data(:,6)];

max_Distance = 1000;   % if max_Distance == j then discharge is unit rate per distance (budget)
G = 0;
i = numClusters*2; % number of vertices needed to be multiplied by battery levels
j = 100;
tTO = 100;           % take off cost
tL = 100;            % landing cost
rRate = 2;         % rate of recharge
UGVS = 5;          % time to travel one unit for the UGV (greater than 1 means UGV is slower)
method = 1;        % 1 = GLNS, 0 = con  corde

filename1 = sprintf('kentLand%d1',trial);
filename2 = sprintf('/home/klyu/lab/coverageWork/testForCoverage/fieldExperiments/kentLand%d2.gtsp', trial);
filename3 = sprintf('kentLand%d3',trial);

tic
pathName = '/home/klyu/lab/coverageWork/testForCoverage/fieldExperiments';
% pathName = '/home/klyu/lab/coverageWork/testForCoverage/errorInstance'; % for error instances
[ansTime,gtspMatrix,gtspTime, v_Cluster] = testGeneral(i, j, filename1, tTO, tL, rRate, UGVS, G, x, y, method, max_Distance, pathName,UGVCapable);

% making GLNS matrix input
roundedGtspMatrix = round(gtspMatrix);
roundedGtspMatrix(roundedGtspMatrix == -1) = 999999;
roundedGtspMatrix(roundedGtspMatrix == Inf) = 999999;
createGTSPFile(filename2,roundedGtspMatrix, i, j, v_Cluster) % creating GLNS file
f = fullfile(pathName, filename3);
save(f);
toc