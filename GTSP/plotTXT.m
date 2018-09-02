% plotTXT
% plots the input .txt files without using any other code
clear
clc
close
filename = 'inputs/costVSbudget1.txt'
data = readData(filename); % get the size and shape from the data (this will tell you number of clusters points and so on)
[numClusters, ~] = size(data);
x = [data(:,1), data(:,4)];
y = [data(:,2), data(:,5)];
UGVCapable = [data(:,3), data(:,6)];
X1 = data(:,1)';
X2 = data(:,4)';
Y1 = data(:,2)';
Y2 = data(:,5)';
tempX1 = rand(1, 10);
tempX2 = rand(1, 10);
tempY1 = rand(1, 10);
tempY2 = rand(1, 10);
plot([X1; X2], [Y1; Y2], 'linewidth', 2)
axis equal
title('Input Boustrophedon Cells')
