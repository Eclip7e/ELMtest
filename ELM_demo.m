X=ParseCSV('unixdates.csv');
Y=X;
elm = ELM_Class(6,500,6,'sig',1);
disp('training time:')
tic
trainedelm = train(elm,X,Y);
toc
pred = predict(trainedelm,X);
disp('R2 error');
ComputeR2(X,pred)
