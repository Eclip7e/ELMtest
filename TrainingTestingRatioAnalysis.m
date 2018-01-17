% %% sensitivity analysis on training testing ratio.
X=ParseCSV('unixdates.csv');

%truncating X dates and volume not needed
X=X(:,2:end-1);
actFun='linear';
nInputs = 30;
nOutputs = 10;
nFeatures = size(X,2);
bias = 1;
nHidden    = 200;
ratios = 5:10:100;
trainMSE   = zeros(size(nHidden));
testMSE   = zeros(size(nHidden));
trainTimes = 1:numel(ratios);

ELM = ELM_Class(nInputs,nHidden,nOutputs,nFeatures,actFun,bias);
[oX,oY]=rearrangeData(ELM,X);
for i = 1 : numel(ratios)
   
    [Xtest,Ytest,Xtrain,Ytrain] = setProportionsOfData(oX,oY,ratios(i));
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
sprintf('Total training time of same network with %d different train/test ratios:%d (s)',numel(ratios),sum(trainTimes))
% plot results
plot(ratios,[trainMSE;testMSE],'-o');
xlabel('Train data percentage');
ylabel('Mean square error');
legend({'training','testing'},'Location','southeast')

 figure
 plot(ratios,trainTimes,'-o');
 title('Training time(s) vs percentage of Train data');
 xlabel('Train data percentage'); % x-axis label
 ylabel('Training time');