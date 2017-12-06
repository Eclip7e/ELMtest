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
pred = predict(trainedelm,Xtest);
%removing unixtimestamps and volumes as its not neededm we are interested
%with prices!
% pred=pred(:,2:end-1);
% Ytest=Ytest(:,2:end-1);
disp('R2 error');
ComputeR2(Ytest,pred)
plotComparison(pred,Ytest)