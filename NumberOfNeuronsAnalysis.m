% %% sensitivity analysis on number of hidden neurons
X=ParseCSV('unixdates.csv');
[X,Y] = rearrangingData6feat(X);
[Xtest,Ytest,Xtrain,Ytrain] = setProportionsOfData(X,Y,80);

actFun='sig';
nInputs = 30;
nHidden    = 1:50:1000;
trainR2   = zeros(size(nHidden));
testR2   = zeros(size(nHidden));
for i = 1 : numel(nHidden)
    ELM = ELM_Class(nInputs,nHidden(i),6,actFun,1);
    % train ELM on the training dataset
    ELM = train(ELM,Xtrain,Ytrain);
    Yhat = predict(ELM,Xtrain);
    trainR2(i) = ComputeR2(Ytrain(:,2:end-1),Yhat(:,2:end-1));
    % validation of ELM model
    Yhat = predict(ELM,Xtest);
    testR2(i) = ComputeR2(Ytest(:,2:end-1),Yhat(:,2:end-1));
end

% plot results
plot(nHidden,[trainR2;testR2],'-o');
xlabel('Number of Hidden Neurons');
ylabel('R square error');
legend({'training','testing'},'Location','southeast')