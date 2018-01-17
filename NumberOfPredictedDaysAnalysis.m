% %% sensitivity analysis on different number of predicted days with 30 days as input.
X=ParseCSV('unixdates.csv');

%truncating X dates and volume not needed
X=X(:,2:end-1);
actFun='linear';
nInputs = 30;
nOutputs = 1:40;
nFeatures = size(X,2);
bias = 1;
nHidden    =nInputs*nFeatures+nOutputs*nFeatures;
trainMSE   = zeros(size(nHidden));
testMSE   = zeros(size(nHidden));
trainTimes = 1:numel(nOutputs);


for i = 1 : numel(nOutputs)
    ELM = ELM_Class(nInputs,nHidden(i),nOutputs(i),nFeatures,actFun,bias);
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
sprintf('Total training time different networks with %d  different number of predicted days ratios:%d (s)',numel(nOutputs),sum(trainTimes))
% plot results
plot(nOutputs,[trainMSE;testMSE],'-o');
xlabel('Number of Predicted days');
ylabel('Mean square error');
legend({'training','testing'},'Location','southeast')

 figure
 plot(nOutputs,trainTimes,'-o');
 title('Training time(s) vs Number of Predicted days');
 xlabel('Number of predicted days'); % x-axis label
 ylabel('Training time');