% plots for ICRA 2019
% used file "costVSbudget1.txt" for costVSbudgetnonUnit and
% costVSbudgetUnit

% used files in "timeVSi" folder for timeVSsite



dbstop error
clear all
close all

load timeValues_checkIfRight.mat

% plot for cost vs budget
% figure(1)
% plot(costVSbudgetnonUnit(:,1), costVSbudgetnonUnit(:,2))
% hold on
% plot(costVSbudgetUnit(:,1),costVSbudgetUnit(:,2))
% 
% title('Cost VS. Budget')
% legend(['NonUnit Budget'],['Unit Budget'])
% xlabel('Budget')
% ylabel('Tour Cost')

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
