clear
close all
load rando1.mat
GLNSSolution = [12, 7, 13, 25]


GLNSSolution = fliplr(GLNSSolution);
GLNSSolutionOriginalPoints = ceil(GLNSSolution./numBatteryLevels);

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

% GLNSx(end+1) = 0;
% GLNSy(end+1) = 0;
GLNSg = digraph;
GLNSg = addnode(GLNSg, numPointsInit+1);
figure(1)
plot(GLNSx, GLNSy,'.')
axis equal
title('Initial Graph Without Edge Costs Edges are Euclidean Distance Between Points')
% S2 = zeros(1,numel(GLNSx)-1);
% T2 = S2;
% for a = 1:numel(GLNSx)
%     S2(a) = a;
%     T2(a) = a+1;
% end
%
% GLNSg = addedge(GLNSg,S2,T2);

S3 = [];
S4 = S3;
S5 = S3;
S6 = S3;
S7 = S3;
T3 = S3;
T4 = S3;
T5 = S3;
T6 = S3;
T7 = S3;

for a = 1:(numPointsInit/2)
    if GLNSSolutionOriginalPoints(a) > numel(x1)
        
    else
        typeChecker = v_Type(GLNSSolution(a),GLNSSolution(a+1));
        if typeChecker == 1
            S3(end+1) = a;
            T3(end+1) = a+1;
        elseif typeChecker == 2
            S4(end+1) = a;
            T4(end+1) = a+1;
        elseif typeChecker == 3
            S5(end+1) = a;
            T5(end+1) = a+1;
        elseif typeChecker == 4
            S6(end+1) = a;
            T6(end+1) = a+1;
        elseif typeChecker == 5
            S7(end+1) = a;
            T7(end+1) = a+1;
        else
            disp('error')
        end
    end
end

S8 = [];
T8 = [];
for i = 1:numel(GLNSx)
    for j = i+1:numel(GLNSx)
        S8(end+1) = i;
        T8(end+1) = j;
    end
end

GLNSg = addedge(GLNSg,S8,T8);
figure(2)
GLNSPlot = plot(GLNSg,'XData',GLNSx,'YData',GLNSy, 'LineWidth',4, 'EdgeColor', 'w');
axis equal



hold on
% highlight edges for UAV
% if isempty(S4) == 0                 %highlight type 2 edges
%     highlight(GLNSPlot,S4, T4,'EdgeColor','r','LineWidth',4, 'LineStyle', '-')
% end
% if isempty(S5) == 0                 %highlight type 3 edges
%     highlight(GLNSPlot,S5, T5,'EdgeColor','r','LineWidth',4, 'LineStyle', '-')
% end
% % highlighting edges for UGV
% highlight(GLNSPlot, S8, T8, 'EdgeColor', 'r', 'LineWidth', 4)

% highlight(GLNSPlot, S2)             %highlights nodes
% highlight(GLNSPlot, numel(S2)+1)    %highlights last node
% % close all;
