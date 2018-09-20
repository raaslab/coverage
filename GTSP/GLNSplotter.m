% GLNSplotter.m
% plots the output from the GLNS solver. This file requires the output from
% GLNS in "GLNSSolution" and the two files rando3.mat and rando1.mat.

clear
close all
load /home/klyu/lab/coverageWork/testForCoverage/qualitative/qualitative33.mat
load /home/klyu/lab/coverageWork/testForCoverage/qualitative/qualitative31.mat

% GLNSSolution = [2301, 918, 2130, 707, 1955, 1101, 2521, 555, 1763, 371, 1579, 187, 1395, 2601] % kentLand2
% GLNSSolution = [781, 702, 361, 625, 735, 510, 1059, 594, 305, 268, 1201] % fieldExperiment2
% exampleFigureBC
% GLNSSolution = [581, 1927, 633, 2021, 725, 2069, 773, 2117, 802, 2147, 693, 1997, 645, 1890, 556, 1842, 507, 1812, 437, 1763, 468, 414, 1715, 377, 1342, 9, 1361, 108, 1675, 1442, 86, 1393, 143, 1487, 191, 1534, 237, 1561, 263, 1605, 307, 1648, 2233, 881, 2183, 2164, 946, 2254, 962, 2309, 1021, 2326, 1052, 2397, 1084, 1109, 2453, 1157, 2484, 1188, 2532, 1236, 2565, 1269, 2613, 1317, 2641]

% qualitative work
GLNSSolution = [281, 23, 325, 67, 369, 111, 135, 438, 169, 472, 215, 267, 532, 237, 561]


% plotTXT('/home/klyu/lab/coverageWork/coverage/GTSP/inputs/fieldExperiments/exampleFigureBC.txt')

v_Cluster = cell2mat(v_Cluster);
while GLNSSolution(1) ~= (numPointsInit * numBatteryLevels)+1
    GLNSSolution = circshift(GLNSSolution, 1);
end
GLNSSolution(end+1) = GLNSSolution(1);
GLNSSolutionOriginalPoints = ceil(GLNSSolution./numBatteryLevels);

orig_V_Cluster = zeros([numPointsInit, 1]);
for i = 1:numPointsInit
    orig_V_Cluster(i) = v_Cluster(i*numBatteryLevels);
end

GLNSSolutionWithAllPoints = GLNSSolutionOriginalPoints;
counter = 1;
for i = 1:length(GLNSSolutionOriginalPoints)
    if GLNSSolutionOriginalPoints(i) > numPointsInit
        counter = counter+1;
    else
        clusterToFind = orig_V_Cluster(GLNSSolutionOriginalPoints(i));
        tempNewData = find(orig_V_Cluster == clusterToFind);
        if tempNewData(1) ~= GLNSSolutionOriginalPoints(i)
            GLNSSolutionWithAllPoints = [GLNSSolutionWithAllPoints(1:counter), tempNewData(1), GLNSSolutionWithAllPoints(counter+1:end)];
            counter = counter+2;
        else
            GLNSSolutionWithAllPoints = [GLNSSolutionWithAllPoints(1:counter), tempNewData(2), GLNSSolutionWithAllPoints(counter+1:end)];
            counter = counter+2;
        end
    end
end

GLNSx = zeros(1,numel(x1)/2);
GLNSy = zeros(1,numel(y1)/2);

for a = 1:(numPointsInit)+1
    if a == 1
        GLNSx;
    else
        GLNSx(a) = x1(a-1);
        GLNSy(a) = y1(a-1);
    end
end
GLNSx = circshift(GLNSx, -1);
GLNSy = circshift(GLNSy, -1);
GLNSg = digraph;
GLNSg = addnode(GLNSg, numPointsInit+1);

% figure(1)
% plot(GLNSx, GLNSy,'-')
% axis equal
% title('Initial Graph Without Edge Costs Edges are Euclidean Distance Between Points')

S2 = zeros(1,numel(GLNSx)-2);
T2 = S2;
for a = 2:numel(GLNSx)-1
    S2(a-1) = GLNSSolutionWithAllPoints(a);
    T2(a-1) = GLNSSolutionWithAllPoints(a+1);
end

GLNSg = addedge(GLNSg,S2,T2);

S3 = []; % typeA
S4 = S3; % typeB
S5 = S3; % typeC
S6 = S3; % typeD
S7 = S3; % typeE
T3 = S3;
T4 = S3;
T5 = S3;
T6 = S3;
T7 = S3;
impossible = 0;
lastPoint = 0;
for a = 2:(numPointsInit/2)+1
    if a == (numPointsInit/2)+1
        lastPoint = 1;
        typeChecker = v_Type(GLNSSolution(a),GLNSSolution(a+1));
        locationStart = find(GLNSSolutionWithAllPoints == GLNSSolutionOriginalPoints(a));
        locationEnd = find(GLNSSolutionWithAllPoints == GLNSSolutionOriginalPoints(a+1),1,'last');
    else
        typeChecker = v_Type(GLNSSolution(a),GLNSSolution(a+1));
        locationStart = find(GLNSSolutionWithAllPoints == GLNSSolutionOriginalPoints(a));
        locationEnd = find(GLNSSolutionWithAllPoints == GLNSSolutionOriginalPoints(a+1));
    end
    if typeChecker == 1 % typeA
        S3(end+1) = GLNSSolutionWithAllPoints(locationStart);
        T3(end+1) = GLNSSolutionWithAllPoints(locationEnd-1);
        if lastPoint == 0
            S3(end+1) = GLNSSolutionWithAllPoints(locationStart+1);
            T3(end+1) = GLNSSolutionWithAllPoints(locationEnd);
        end
    elseif typeChecker == 2 % typeB
        S4(end+1) = GLNSSolutionWithAllPoints(locationStart);
        T4(end+1) = GLNSSolutionWithAllPoints(locationEnd-1);
        if lastPoint == 0
            S4(end+1) = GLNSSolutionWithAllPoints(locationStart+1);
            T4(end+1) = GLNSSolutionWithAllPoints(locationEnd);
        end
    elseif typeChecker == 3 % typeC
        S5(end+1) = GLNSSolutionWithAllPoints(locationStart);
        T5(end+1) = GLNSSolutionWithAllPoints(locationEnd-1);
        if lastPoint == 0
            S5(end+1) = GLNSSolutionWithAllPoints(locationStart+1);
            T5(end+1) = GLNSSolutionWithAllPoints(locationEnd);
        end
    elseif typeChecker == 4 % typeD
        S6(end+1) = GLNSSolutionWithAllPoints(locationStart);
        T6(end+1) = GLNSSolutionWithAllPoints(locationEnd-1);
        if lastPoint == 0
            S6(end+1) = GLNSSolutionWithAllPoints(locationStart+1);
            T6(end+1) = GLNSSolutionWithAllPoints(locationEnd);
        end
    elseif typeChecker == 5 % typeE
        S7(end+1) = GLNSSolutionWithAllPoints(locationStart);
        T7(end+1) = GLNSSolutionWithAllPoints(locationEnd-1);
        if lastPoint == 0
            S7(end+1) = GLNSSolutionWithAllPoints(locationStart+1);
            T7(end+1) = GLNSSolutionWithAllPoints(locationEnd);
        end
    else
        impossible = 1;
        disp('error')
        break
    end
    lastPoint = 0;
end

S8 = [];
T8 = [];
for i = 1:numel(GLNSx)
    for j = i+1:numel(GLNSx)
        S8(end+1) = i;
        T8(end+1) = j;
    end
end

if impossible == 0
    % GLNSg = addedge(GLNSg,S8,T8);
    figure(2)
    GLNSPlot = plot(GLNSg,'XData',GLNSx,'YData',GLNSy, 'LineWidth',3, 'EdgeColor', [0,0,1]);
    GLNSPlot.EdgeAlpha = 1;

    GLNSPlot.NodeLabel = {};
    axis equal
%     axis([40 1675 50 800])
    groupedPoints = cell2mat(groupedPoints);
    
    %     for i = 2:length(GLNSSolution)-1
    %         text(GLNSx(groupedPoints(GLNSSolution(i))), GLNSy(groupedPoints(GLNSSolution(i)))+0.1, num2str(v_ClusterLevels(GLNSSolution(i))), 'FontSize', 16)
    %     end
    hold on
    
    % highlight edges for UAV
    %     if isempty(S3) == 0                 %highlight type 1 edges: F-F
    %         highlight(GLNSPlot,S3, T3,'EdgeColor','b','LineWidth',4, 'LineStyle', '-')
    %     end
    if isempty(S4) == 0                 %highlight type 2 edges: F-FDU
        highlight(GLNSPlot,S4, T4,'EdgeColor',[1,0,0],'LineWidth',3, 'LineStyle', '-')
    end
    if isempty(S5) == 0                 %highlight type 3 edges: FDU-FDU
        highlight(GLNSPlot,S5, T5,'EdgeColor',[0,1,0],'LineWidth',3, 'LineStyle', '-')
    end
    if isempty(S6) == 0                 %highlight type 4 edges: FDU-F
        highlight(GLNSPlot,S6, T6,'EdgeColor',[1,0.1034,0.7241],'LineWidth',3, 'LineStyle', '-')
    end
    if isempty(S7) == 0                 %highlight type 5 edges: F-DTU
        highlight(GLNSPlot,S7, T7,'EdgeColor',[1,0.8276,0],'LineWidth',3, 'LineStyle', '-')
    end

    % highlighting edges for UGV
    % highlight(GLNSPlot, S8, T8, 'EdgeColor', 'r', 'LineWidth', 4)
    
%     highlight(GLNSPlot, S2)             %highlights nodes
%     highlight(GLNSPlot, numel(S2))    %highlights last node
    
    h = zeros(5, 1);
    h(1) = plot(NaN,NaN,'color', [0,0,1]);
    h(2) = plot(NaN,NaN,'color', [1,0,0]);
    h(3) = plot(NaN,NaN,'color', [0,1,0]);
    h(4) = plot(NaN,NaN,'color', [1,0.1034,0.7241]);
    h(5) = plot(NaN,NaN,'color', [1,0.8276,0]);
    legg = legend(h, 'F-F','F-FDU','F-DUFDU','F-DUF','F-DTU');
    legg.FontSize = 9;
else
    disp('impossible input');
end

hold on
for i = 2:2:length(GLNSx)-1
    [cord,~,~] = createRectangle(GLNSx(GLNSSolutionWithAllPoints(i)), GLNSy(GLNSSolutionWithAllPoints(i)), GLNSx(GLNSSolutionWithAllPoints(i+1)), GLNSy(GLNSSolutionWithAllPoints(i+1)));
    plot(cord(:,1),cord(:,2), 'color', 'k', 'linewidth',2)
    
end

title('Output Tour', 'Fontsize', 16)
% set(gca,'Ydir','reverse')

% close all;