% plotTXT
% plots the input .txt files without using any other code

function [] = plotTXT(filename)
figure()
data = readData(filename); % get the size and shape from the data (this will tell you number of clusters points and so on)
X1 = data(:,1)';
X2 = data(:,4)';
Y1 = data(:,2)';
Y2 = data(:,5)';
plot([X1; X2], [Y1; Y2], 'linewidth', 2)
hold on
plot(0,0)
axis equal
% axis([-20 119 -9 101])
title('Input Boustrophedon Cells')
end