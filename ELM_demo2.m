X=ParseCSV('unixdates.csv');
X1=X;
[X,Y] = rearrangingData6feat(X);
[Xtest,Ytest,Xtrain,Ytrain] = setProportionsOfData(X,Y,80);
elm1 = ELM_Class(5,30,1,'linear',1);
[oX1,oY1]=rearrangeData(elm1,X1);
elm = ELM_Class(30,500,6,'linear',1);
disp('training time:')
tic
trainedelm = train(elm,Xtrain,Ytrain);
toc
pred = predict(trainedelm,Xtest);
%removing unixtimestamps and volumes as its not neededm we are interested
%with prices!
pred=pred(:,2:end-1);
Ytest=Ytest(:,2:end-1);
disp('R2 error');
ComputeR2(Ytest,pred)
plotComparison(pred,Ytest)