% specificRuns
% this will run a specific case for if there's an error within "time"
% variable
dbstop error
% clc; clear all; close all;
addpath('edgeTypes')
addpath('combos')
% timei = [];
max_Distance = 100;   % if max_Distance == j then discharge is unit rate per distance (budget)
G = 0;
% x = 0;
% y = 0;
% j = 20;             % number of battery levels
tTO = 10;           % take off cost
tL = 10;            % landing cost
rRate = 2;         % rate of recharge
UGVS = 5;          % time to travel one unit for the UGV (greater than 1 means UGV is slower)
method = 1;        % 1 = GLNS, 0 = con  corde
%     filename = [num2str(i) '_' num2str(j) 'GNLS' num2str(z)];

% for trialsLoop = 3:10
%     display(trialsLoop)
%     for forLoopVariable = 10:7:80
%         display(forLoopVariable)
%         filename4 = sprintf('inputs/timeVSi/%di_%d.txt', trialsLoop,forLoopVariable);
% %         polygonCreater(filename4,forLoopVariable,100,0,1) % creates random polygons.
%         
%         % use 'testInput.txt' if you want the file from polygonCreater
%         data = readData(filename4); % get the size and shape from the data (this will tell you number of clusters points and so on)
%         [numClusters, ~] = size(data);
%         x = [data(:,1), data(:,4)];
%         y = [data(:,2), data(:,5)];
%         UGVCapable = [data(:,3), data(:,6)];
%         
%         tic
%         i = numClusters*2; % number of vertices needed to be multiplied by battery levels
%         j = 20;
%         filename1 = sprintf('%d1_%d', trialsLoop,forLoopVariable);
%         filename2 = sprintf('/home/klyu/lab/coverageWork/coverage/GTSP/inputs/timeVSi/%d2_%d.gtsp', trialsLoop,forLoopVariable);
%         filename3 = sprintf('%d3_%d',trialsLoop, forLoopVariable);
%         
%         pathName = '/home/klyu/lab/coverageWork/coverage/GTSP/inputs/timeVSi';
%         % pathName = '/home/klyu/lab/coverageWork/testForCoverage/errorInstance'; % for error instances
%         [ansTime,gtspMatrix,gtspTime, v_Cluster] = testGeneral(i, j, filename1, tTO, tL, rRate, UGVS, G, x, y, method, max_Distance, pathName,UGVCapable);
%         
%         % making GLNS matrix input
%         roundedGtspMatrix = round(gtspMatrix);
%         roundedGtspMatrix(roundedGtspMatrix == -1) = 999999;
%         roundedGtspMatrix(roundedGtspMatrix == Inf) = 999999;
%         % filename = ['/home/klyu/lab/coverageWork/testForCoverage/errorInstance/rando2.gtsp'];
%         createGTSPFile(filename2,roundedGtspMatrix, i, j, v_Cluster) % creating GLNS file
%         f = fullfile(pathName, filename3);
%         save(f);
%         trialTime = toc;
%         timei(end+1, :) = [double(trialsLoop), double(forLoopVariable), trialTime];
%     end
% end

% trialsLoop = 1; forLoopVariable = 24
timej = [];
for trialsLoop = 1:5
    display(trialsLoop)
    for forLoopVariable = 10:7:80
        display(forLoopVariable)
        filename4 = sprintf('inputs/timeVSj/%dj_%d.txt', trialsLoop,forLoopVariable);
        polygonCreater(filename4,30,100,0,1) % creates random polygons.
        
        % use 'testInput.txt' if you want the file from polygonCreater
        data = readData(filename4); % get the size and shape from the data (this will tell you number of clusters points and so on)
        [numClusters, ~] = size(data);
        x = [data(:,1), data(:,4)];
        y = [data(:,2), data(:,5)];
        UGVCapable = [data(:,3), data(:,6)];
        
        tic
        i = numClusters*2; % number of vertices needed to be multiplied by battery levels
        j = forLoopVariable;
        filename1 = sprintf('%d1_%d', trialsLoop,forLoopVariable);
        filename2 = sprintf('/home/klyu/lab/coverageWork/coverage/GTSP/inputs/timeVSj/%d2_%d.gtsp', trialsLoop,forLoopVariable);
        filename3 = sprintf('%d3_%d',trialsLoop, forLoopVariable);
        
        pathName = '/home/klyu/lab/coverageWork/coverage/GTSP/inputs/timeVSj';
        % pathName = '/home/klyu/lab/coverageWork/testForCoverage/errorInstance'; % for error instances
        [ansTime,gtspMatrix,gtspTime, v_Cluster] = testGeneral(i, j, filename1, tTO, tL, rRate, UGVS, G, x, y, method, max_Distance, pathName,UGVCapable);
        
        % making GLNS matrix input
        roundedGtspMatrix = round(gtspMatrix);
        roundedGtspMatrix(roundedGtspMatrix == -1) = 999999;
        roundedGtspMatrix(roundedGtspMatrix == Inf) = 999999;
        % filename = ['/home/klyu/lab/coverageWork/testForCoverage/errorInstance/rando2.gtsp'];
        createGTSPFile(filename2,roundedGtspMatrix, i, j, v_Cluster) % creating GLNS file
        f = fullfile(pathName, filename3);
        save(f);
        trialTime = toc;
        timej(end+1, :) = [double(trialsLoop), double(forLoopVariable), trialTime];
    end
end

save('timeValues_checkIfRight.mat')