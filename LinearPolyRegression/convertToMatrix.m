function [matrix] = convertToMatrix(table)
%CONVERTTOMATRIX Summary of this function goes here
%   Detailed explanation goes here

% Makes a temporary table
t = table;

% Replaces qualities with numbers (worst to best)
t.cut(strcmp(t.cut,'Fair')) = {1};
t.cut(strcmp(t.cut,'Good')) = {2};
t.cut(strcmp(t.cut,'Very Good')) = {3};
t.cut(strcmp(t.cut,'Premium')) = {4};
t.cut(strcmp(t.cut,'Ideal')) = {5};

% Replaces color letters with numbers (worst to best)
t.color(strcmp(t.color,'J')) = {1};
t.color(strcmp(t.color,'I')) = {2};
t.color(strcmp(t.color,'H')) = {3};
t.color(strcmp(t.color,'G')) = {4};
t.color(strcmp(t.color,'F')) = {5};
t.color(strcmp(t.color,'E')) = {6};
t.color(strcmp(t.color,'D')) = {7};

% Replaces clarity IDs with numbers (worst to best)
t.clarity(strcmp(t.clarity,'I1')) = {1};
t.clarity(strcmp(t.clarity,'SI2')) = {2};
t.clarity(strcmp(t.clarity,'SI1')) = {3};
t.clarity(strcmp(t.clarity,'VS2')) = {4};
t.clarity(strcmp(t.clarity,'VS1')) = {5};
t.clarity(strcmp(t.clarity,'VVS2')) = {6};
t.clarity(strcmp(t.clarity,'VVS1')) = {7};
t.clarity(strcmp(t.clarity,'IF')) = {8};

% Converts table to all have cells (allows concatination of )
cellT = table2cell(t);

% Converts cell array to matrix so we can work on it :)
matrix = cell2mat(cellT);

end

