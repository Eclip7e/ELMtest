 %Author: Mateusz Grossman
    %Date: 07/01/2018
function [Xtest,Ytest,Xtrain,Ytrain] = setProportionsOfData(X,Y,perc)
%SETPROPORTIONSOFDATA Summary of this function goes here
%   Detailed explanation goes here
% sets proportion of training data and test data
% perc is percentage of training data, so if perc is 80 training data will
% be 80% of data and test data will be 20%
%int 32 to hold really big values if needed

trainingSize = int32(perc * size(X, 1) / 100);

Xtrain = X(1:trainingSize,:);
Ytrain = Y(1:trainingSize,:);
Xtest=X(trainingSize+1:end,:);
Ytest=Y(trainingSize+1:end,:);


            
end

