% %% sensitivity analysis on number of hidden neurons
X=ParseCSV('unixdates.csv');
%[X,Y] = rearrangingData6feat(X);
%[Xtest,Ytest,Xtrain,Ytrain] = setProportionsOfData(X,Y,80);

%truncating X dates and volume not needed
X=X(:,2:end-1);

actFun='linear';
nInputs = 30;
nOutputs = 10;
nFeatures = size(X,2);
bias = 1;
nHidden    = 1:50:1000;
trainMSE   = zeros(size(nHidden));
testMSE   = zeros(size(nHidden));
trainTimes = 1:numel(nHidden);
for i = 1 : numel(nHidden)
    ELM = ELM_Class(nInputs,nHidden(i),nOutputs,nFeatures,actFun,bias);
    %rearranging and setting proportions could be moved above for loop and
    %would be faster, but it would require creating ELM beforehand as
    %rearrangedata function is method from ELM_Class.
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
sprintf('Training time(s) of %d networks with different number of Hidden Neurons :%0.5f',numel(nHidden),sum(trainTimes))
% plot results
plot(nHidden,[trainMSE;testMSE],'-o');
xlabel('Number of Hidden Neurons');
ylabel('Mean square error');
legend({'training','testing'},'Location','southeast')

 figure
 plot(1:size(trainTimes,2),trainTimes);
 title('Training time(s) vs number of hidden neurons');
 xlabel('Number of hidden neurons'); % x-axis label
 ylabel('Training time');