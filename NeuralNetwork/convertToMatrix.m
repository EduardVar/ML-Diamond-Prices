function [matrix] = convertToMatrix(table)
%CONVERTTOMATRIX Summary of this function goes here
%   Detailed explanation goes here

% Makes a temporary table
t = table;

% Replaces qualities with numbers (worst to best)
t.cut(strcmp(t.cut,'Fair')) = {0};
t.cut(strcmp(t.cut,'Good')) = {1};
t.cut(strcmp(t.cut,'Very Good')) = {2};
t.cut(strcmp(t.cut,'Premium')) = {3};
t.cut(strcmp(t.cut,'Ideal')) = {4};

% Replaces color letters with numbers (worst to best)
t.color(strcmp(t.color,'J')) = {0};
t.color(strcmp(t.color,'I')) = {1};
t.color(strcmp(t.color,'H')) = {2};
t.color(strcmp(t.color,'G')) = {3};
t.color(strcmp(t.color,'F')) = {4};
t.color(strcmp(t.color,'E')) = {5};
t.color(strcmp(t.color,'D')) = {6};

% Replaces clarity IDs with numbers (worst to best)
t.clarity(strcmp(t.clarity,'I1')) = {0};
t.clarity(strcmp(t.clarity,'SI2')) = {1};
t.clarity(strcmp(t.clarity,'SI1')) = {2};
t.clarity(strcmp(t.clarity,'VS2')) = {3};
t.clarity(strcmp(t.clarity,'VS1')) = {4};
t.clarity(strcmp(t.clarity,'VVS2')) = {5};
t.clarity(strcmp(t.clarity,'VVS1')) = {6};
t.clarity(strcmp(t.clarity,'IF')) = {7};

% Converts table to all have cells (allows concatination of )
cellT = table2cell(t);

% Converts cell array to matrix so we can work on it :)
matrix = cell2mat(cellT);

end

