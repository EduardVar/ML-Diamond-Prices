% Author: 

%% Initialization
clear ; close all; clc

% Loads in csv data table
table = readtable("diamonds.csv");

% Cleans up table and return matrix of numerical values for lin reg
data = convertToMatrix(table);

% Test to see if the first 5 examples are formatted correctly
disp(data(1:5, :));
