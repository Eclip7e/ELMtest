function C = ParseCSV(csvfilename)
%PARSECSV Summary of this function goes here
%   Detailed explanation goes here
C=readtable(csvfilename);
C=table2array(C);
end

