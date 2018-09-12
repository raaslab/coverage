% specificRuns
% this will run a specific case for if there's an error within "time"
% variable

% FINISHED USE DON'T CHANGE FILE
% USE "specificRuns" IF YOU WANT TO DO MORE RUNS
% OR MAKE A COPY OF "specificRuns" AND USE THAT

dbstop error
clc; clear all; close all;

G = 0;
% x = 0;
% y = 0;
% j = 20;             % number of battery levels
tTO = 1000;           % take off cost
tL = 1000;            % landing cost
rRate = 2;         % rate of recharge
UGVS = 5;          % time to travel one unit for the UGV (greater than 1 means UGV is slower)
method = 1;        % 1 = GLNS, 0 = con  corde

data = readData('inputs/costVSbudget1.txt'); % get the size and shape from the data (this will tell you number of clusters points and so on)
[numClusters, ~] = size(data);
x = [data(:,1), data(:,4)];
y = [data(:,2), data(:,5)];
UGVCapable = [data(:,3), data(:,6)];

timeUnit = [];
for forLoopVariable = 10:25
%     display(forLoopVariable)
    tic
    max_Distance = forLoopVariable;   % if max_Distance == j then discharge is unit rate per distance (budget)
    i = numClusters*2; % number of vertices needed to be multiplied by battery levels
%     j = forLoopVariable;
    j = 25;
    filename1 = sprintf('1_%d', forLoopVariable);
    filename2 = sprintf('/home/klyu/lab/coverageWork/testForCoverage/costVSbudget/2_%d.gtsp', forLoopVariable);
    filename3 = sprintf('3_%d', forLoopVariable);
    
    pathName = '/home/klyu/lab/coverageWork/testForCoverage/costVSbudget/';
    [ansTime,gtspMatrix,gtspTime, v_Cluster] = testGeneral(i, j, filename1, tTO, tL, rRate, UGVS, G, x, y, method, max_Distance, pathName,UGVCapable);
    
    % making GLNS matrix input
    roundedGtspMatrix = round(gtspMatrix);
    roundedGtspMatrix(roundedGtspMatrix == -1) = 999999;
    roundedGtspMatrix(roundedGtspMatrix == Inf) = 999999;
    createGTSPFile(filename2,roundedGtspMatrix, i, j, v_Cluster) % creating GLNS file
    f = fullfile(pathName, filename3);
    save(f);
    ElapsedTime = toc
    timeUnit(end+1, :) = [double(forLoopVariable), ElapsedTime];
end



% % Double
% timeDouble = [];
% for forLoopVariable = 10:25
%     display(forLoopVariable)
%     tic
%     max_Distance = forLoopVariable;   % if max_Distance == j then discharge is unit rate per distance (budget)
%     i = numClusters*2; % number of vertices needed to be multiplied by battery levels
% %     j = forLoopVariable*2;
%     j 100;
%     filename1 = sprintf('1_%d', forLoopVariable);
%     filename2 = sprintf('/home/klyu/lab/coverageWork/testForCoverage/costVSbudget/DoubleUnit/2_%d.gtsp', forLoopVariable);
%     filename3 = sprintf('3_%d', forLoopVariable);
%     
%     pathName = '/home/klyu/lab/coverageWork/testForCoverage/costVSbudget/DoubleUnit/';
%     [ansTime,gtspMatrix,gtspTime, v_Cluster] = testGeneral(i, j, filename1, tTO, tL, rRate, UGVS, G, x, y, method, max_Distance, pathName,UGVCapable);
%     
%     % making GLNS matrix input
%     roundedGtspMatrix = round(gtspMatrix);
%     roundedGtspMatrix(roundedGtspMatrix == -1) = 999999;
%     roundedGtspMatrix(roundedGtspMatrix == Inf) = 999999;
%     createGTSPFile(filename2,roundedGtspMatrix, i, j, v_Cluster) % creating GLNS file
%     f = fullfile(pathName, filename3);
%     save(f);
%     trialTime = toc;
%     timeDouble(end+1, :) = [double(forLoopVariable), trialTime];
% end
% 
% % Triple
% timeTriple = [];
% for forLoopVariable = 10:25
%     display(forLoopVariable)
%     tic
%     max_Distance = forLoopVariable;   % if max_Distance == j then discharge is unit rate per distance (budget)
%     i = numClusters*2; % number of vertices needed to be multiplied by battery levels
% %     j = forLoopVariable*3;
%     j = 100;
%     filename1 = sprintf('1_%d', forLoopVariable);
%     filename2 = sprintf('/home/klyu/lab/coverageWork/testForCoverage/costVSbudget/TripleUnit/2_%d.gtsp', forLoopVariable);
%     filename3 = sprintf('3_%d', forLoopVariable);
%     
%     pathName = '/home/klyu/lab/coverageWork/testForCoverage/costVSbudget/TripleUnit/';
%     [ansTime,gtspMatrix,gtspTime, v_Cluster] = testGeneral(i, j, filename1, tTO, tL, rRate, UGVS, G, x, y, method, max_Distance, pathName,UGVCapable);
%     
%     % making GLNS matrix input
%     roundedGtspMatrix = round(gtspMatrix);
%     roundedGtspMatrix(roundedGtspMatrix == -1) = 999999;
%     roundedGtspMatrix(roundedGtspMatrix == Inf) = 999999;
%     createGTSPFile(filename2,roundedGtspMatrix, i, j, v_Cluster) % creating GLNS file
%     f = fullfile(pathName, filename3);
%     save(f);
%     trialTime = toc;
%     timeTriple(end+1, :) = [double(forLoopVariable), trialTime];
% end
% 
