 %Author: Mateusz Grossman
    %Date: 07/01/2018
function C = ParseCSV(csvfilename)
%PARSECSV Summary of this function goes here
%   Detailed explanation goes here
C=readtable(csvfilename);
%removing date & volume, because they are unnecessary for predictions
C=C(:,2:end-1);
C=table2array(C);
end

