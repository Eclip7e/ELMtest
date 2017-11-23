X=ParseCSV('unixdates.csv');
[X,Y] = rearrangingData_4495x6(X);
Xtest=X(1:49,:);
Ytest=Y(1:49,:);
Xtrain = X(50:end,:);
Ytrain = Y(50:end,:);

elm = ELM_Class(30,500,6,'sig',1);
disp('training time:')
tic
trainedelm = train(elm,Xtrain,Ytrain);
toc
pred = predict(trainedelm,Xtest);
disp('R2 error');
ComputeR2(Ytest,pred)
