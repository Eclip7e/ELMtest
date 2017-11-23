function [ W,Y ] = rearrangingData_4495x6(X)
%4495X6_REARRANGINGDATA Summary of this function goes here
%   Detailed explanation goes here
%1)we rearrange data so that 5consecutive rows of X become 1 row and 6th row
%becomes row in Y (our prediction).
%2)WORKS ONLY FOR 6 FEATURES AND (1)
X=X(2:end,:);
%flip X upside down so that latest dates are first
X=flipud(X);
Y=[];
ncols=size(X,2);
nrows = size(X,1);
for i=1:(nrows)
    if(mod(i,6)==0)
        Y(i/6,:)=X(i,:);
    elseif(mod(i,6)==1)
        W(ceil(i/6),1:6)=X(i,:);
    elseif(mod(i,6)==2)
        W(ceil(i/6),7:12)=X(i,:);
    elseif(mod(i,6)==3)
        W(ceil(i/6),13:18)=X(i,:);
    elseif(mod(i,6)==4)
        W(ceil(i/6),19:24)=X(i,:);
    elseif(mod(i,6)==5)
        W(ceil(i/6),25:30)=X(i,:);
    end
end

