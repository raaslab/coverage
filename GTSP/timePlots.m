% plots for ICRA 2019
% used file "costVSbudget1.txt" for costVSbudgetnonUnit and
% costVSbudgetUnit

% used files in "timeVSi" folder for timeVSsite



dbstop error
close all

load plotData.mat

figure(1)
plot(costVSbudgetnonUnit(:,1), costVSbudgetnonUnit(:,2))
hold on
plot(costVSbudgetUnit(:,1),costVSbudgetUnit(:,2))

title('Cost VS. Budget')
legend(['NonUnit Budget'],['Unit Budget'])
xlabel('Budget')
ylabel('Tour Cost')

figure(2)
plot(timeVSsite(:,2),timeVSsite(:,3))