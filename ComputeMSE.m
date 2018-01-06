function mse = ComputeMSE(Y,Yhat,nfeatures)
%COMPUTEMSE Summary of this function goes here
%   Detailed explanation goes here
% Computes MSE for 1 sample, returns array of 4 elements, first element is
% mse for open , 2 element mse for high, 3rd for low, 4th for close price.
mse =zeros(1,nfeatures);

for i=1:nfeatures
    for j=i:nfeatures:size(Yhat,2)
        mse(i)=mse(i)+(Y(j)-Yhat(j))^2;
    end
end
mse=mse./(size(Yhat,2)/nfeatures);

end

