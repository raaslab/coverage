% plots for ICRA 2019
% plots all of the time figures


dbstop error
clear all
close all
clc

load timeData.mat

% plot for cost vs budget
figure(1)
plot(timeUnit(:,1), timeUnit(:,2),'Color','b', 'LineWidth',2)
hold on
plot(timeDouble(:,1),timeDouble(:,2),'Color','r', 'LineWidth',2)
plot(timeTriple(:,1),timeTriple(:,2),'Color','g', 'LineWidth',2)

title('Cost VS. Budget')
legend(['1m per Battery Level'],['2m per Battery Level'], ['3m per Battery Level'])
xlabel('Budget')
ylabel('Tour Cost')

% plot for time vs sites
figure(2)
neg = [];
pos = [];
avgTimeVSsite = [];

for i = 10:7:80
    index = find(timei(:,2)==i);
    averageArray = Inf([1,length(index)]);
    for j = 1:length(index)
        averageArray(j) = timei(index(j),3);
    end
    averageTime = sum(averageArray)/length(averageArray);
    neg(end+1,:) = [i,abs(min(averageArray)-averageTime)];
    pos(end+1,:) = [i,abs(max(averageArray)-averageTime)];
    avgTimeVSsite(end+1,:) = [i,averageTime];
end
errorbar(avgTimeVSsite(:,1),avgTimeVSsite(:,2),neg(:,2), pos(:,2),'MarkerEdgeColor','b','LineWidth', 2)
% axis([8, 82,0,14])
title('Computational Time vs Input Sites')
xlabel('Number of Input Sites')
ylabel('Computational Time (secondes)')

% plot for time vs battery levels
figure(3)
neg = [];
pos = [];
averageTimeVSlevel =[];

for i = 10:7:80
    index = find(timej(:,2)==i);
    averageArray = Inf([1,length(index)]);
    for j = 1:length(index)
        averageArray(j) = timej(index(j),3);
    end
    averageTime = sum(averageArray)/length(averageArray);
    neg(end+1,:) = [i,abs(min(averageArray)-averageTime)];
    pos(end+1,:) = [i, abs(max(averageArray)-averageTime)];
    averageTimeVSlevel(end+1,:) = [i,averageTime];
end
errorbar(averageTimeVSlevel(:,1), averageTimeVSlevel(:,2),neg(:,2),pos(:,2),'MarkerEdgeColor','b','LineWidth', 2)
% axis([8,82,0,14])
title('Computational Time vs Battery Levels')
xlabel('Number of Battery Levels')
ylabel('Computational Time (secondes)')

plotTXT('inputs/costVSbudget1.txt')