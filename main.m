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

% REDUCES DATA TO 1/40 of original size to speed up testing
data = data(1:675, :);

% Uses function to split given data into training, CV, and test set
[X, y, Xval, yval, Xtest, ytest] = splitData(data);

m = size(X, 1);  % Stores number of training examples
n = size(X, 2); % Stores number of features

fprintf('Program paused. Press enter to continue.\n');
pause;

%% Training

% Initializes parameters for training
theta = ones(n + 1, 1); % Sets theta to a matrix of ones (of features)
lambda = 1; % Sets lambda [TESTING REQUIRED]
iter = 200;

% Checks the linear reg function
disp("Checking linearRegFunc.m (Cost and Gradient calculation) ...");
[J, grad] = linearRegFunc([ones(m, 1) X], y, theta, lambda);

disp("Gradient at current theta:");
disp(grad);

% Actually train theta iter times
[theta] = trainLinearReg([ones(m, 1) X], y, lambda, iter);

fprintf('Training Complete. Press enter to continue.\n');
pause;

