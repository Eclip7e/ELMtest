X=ParseCSV('unixdates.csv');
[X,Y] = rearrangingData6feat(X);
[Xtest,Ytest,Xtrain,Ytrain] = setProportionsOfData(X,Y,80);

elm = ELM_Class(30,500,6,'sig',1);
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