 %Author: Mateusz Grossman
    %Date: 07/01/2018
function  plotComparison(pred,realval)
%PLOTOPENCOMPARISON Summary of this function goes here
%   Detailed explanation goes here
t=1:size(pred,1);
figure('Name','Prediction vs Real price of Open')

plot(t,pred(:,1),'+b',t,realval(:,1),'or'); %hold on;
title('Prediction vs Real price of Open')
xlabel('Number of sample') % x-axis label
ylabel('Open Price Value')
legend('predicted value','real value')


figure('Name','Prediction vs Real price of High')

plot(t,pred(:,2),'+b',t,realval(:,2),'or'); %hold on;
title('Prediction vs Real price of high')
xlabel('Number of sample') % x-axis label
ylabel('High Price Value')
legend('predicted value','real value')

figure('Name','Prediction vs Real price of Low')

plot(t,pred(:,3),'+b',t,realval(:,3),'or'); %hold on;
title('Prediction vs Real price of Low')
xlabel('Number of sample') % x-axis label
ylabel('Low Price Value')
legend('predicted value','real value')

figure('Name','Prediction vs Real price of Close')

plot(t,pred(:,4),'+b',t,realval(:,4),'or'); %hold on;
title('Prediction vs Real price of Close')
xlabel('Number of sample') % x-axis label
ylabel('Close Price Value')
legend('predicted value','real value')

end

