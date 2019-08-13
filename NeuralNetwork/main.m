% Author: Eduard Varshavsky

%% Initialization
clear ; close all; clc

% Loads in csv data table
disp("Loading in dataset table ...");
table = readtable("diamonds.csv");

% Cleans up table and return matrix of numerical values for lin reg
disp("Converting table to matrix ...");
data = convertToMatrix(table);

% Test to see if the first 5 examples are formatted correctly
disp("Checks the first five rows of the data ...");
disp(data(1:5, :))

% REDUCES DATA to 5000 examples for testing purposes
data = data(1:5000, :);

% Uses function to split given data into training, CV, and test set
[X, y] = splitData(data);

[m, n] = size(X);  % Stores number of training examples m and features n

% Initializes parameters for training
input_layer_size  = n;  % 9 Input Features (can extend with POLYNOMIALS)
hidden_layer_size = 8;   % 8 hidden units
num_labels = 1;          % 1 output label (price)  

lambda = 1; % WILL NEED TO TRAIN

fprintf('Program initialized. Press enter to continue.\n');
pause;

%%