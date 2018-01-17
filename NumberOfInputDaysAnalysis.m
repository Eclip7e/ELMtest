% %% sensitivity analysis on different number of input days with 5 days output.
X=ParseCSV('unixdates.csv');

%truncating X dates and volume not needed
X=X(:,2:end-1);
actFun='linear';
nInputs = 1:40;
nOutputs = 5;
nFeatures = size(X,2);
bias = 1;
nHidden    =nInputs*nFeatures+nOutputs*nFeatures;
trainMSE   = zeros(size(nHidden));
testMSE   = zeros(size(nHidden));
trainTimes = 1:numel(nOutputs);


for i = 1 : numel(nInputs)
    ELM = ELM_Class(nInputs(i),nHidden(i),nOutputs,nFeatures,actFun,bias);
    [oX,oY]=rearrangeData(ELM,X);
    [Xtest,Ytest,Xtrain,Ytrain] = setProportionsOfData(oX,oY,80);
    % train ELM on the training dataset
    
    tic;
    ELM = train(ELM,Xtrain,Ytrain);
    trainTimes(i)=toc;
    Yhat = predict(ELM,Xtrain);
    trainMSE(i) = immse(Ytrain,Yhat);
    % validation of ELM model
    Yhat = predict(ELM,Xtest);
    testMSE(i) = immse(Ytest,Yhat);
    
end
sprintf('Total training time different networks with %d  different number of input days ratios:%d (s)',numel(nInputs),sum(trainTimes))
% plot results
plot(nInputs,[trainMSE;testMSE],'-o');

 title('Number of Input days predicting 5days MSE');
xlabel('Number of Input days');
ylabel('Mean square error');
legend({'training','testing'},'Location','southeast')

 figure
 plot(nInputs,trainTimes,'-o');
 title('Training time(s) vs Number of Input days');
 xlabel('Number of Input days'); % x-axis label
 ylabel('Training time');