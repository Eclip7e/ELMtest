X=ParseCSV('unixdates.csv');
%removing timestamp and volume (we can rmv timestamp cuz we know its each
%consecutive day)
X=X(:,2:end-1);
elm = ELM_Class(30,30,10,size(X,2),'linear',1);
[oX,oY]=rearrangeData(elm,X);
[Xtest,Ytest,Xtrain,Ytrain] = setProportionsOfData(oX,oY,80);

disp('training time:')
tic
trainedelm = train(elm,Xtrain,Ytrain);
toc
pred = predict(trainedelm,Xtest(1,:));
%removing unixtimestamps and volumes as its not neededm we are interested
%with prices!
% pred=pred(:,2:end-1);
% Ytest=Ytest(:,2:end-1);
disp('R2 error');
ComputeR2(Ytest(1,:),pred)
Yte=Ytest(1,:);
YTT=zeros(1,10);
predd=zeros(1,10);
j=1;
for i=1:4:40
    YTT(j)=Yte(i);
    predd(j)=pred(i);
    j=j+1;
end

t=1:10;
figure('Name','Prediction vs Real price of Open')

plot(t,predd,'b',t,YTT,'r'); %hold on;
title('Prediction vs Real price of Open')
xlabel('day') % x-axis label
ylabel('Open Price Value')
legend('predicted value','real value')


%plotComparison(pred,Ytest)