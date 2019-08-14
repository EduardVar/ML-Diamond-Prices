% Author: Eduard Varshavsky

%% Data Load in
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

disp("Checks the first five rows X ...");
disp(X(1:5, :))

%% Initialization
[m, n] = size(X);  % Stores number of training examples m and features n

% Initializes parameters for training
input_layer_size  = n;  % 9 Input Features (can extend with POLYNOMIALS)
hidden_layer_size = 8;   % 8 hidden units
num_labels = 1;          % 1 output label (price)  

options = optimset('MaxIter', 50);  % Increase iters for more training!
lambda = 1; % WILL NEED TO TRAIN

fprintf('Program initialized. Press enter to continue.\n');
%pause;

%% Normalize Data

disp("Normalizing Data ...");

[X, mu, sigma] = featureNormalize(X);

disp(X(1:5, :));
fprintf('Data Normalized. Press enter to continue.\n');
%pause;

%% Visualize Data
qqplot(X);

%{
% Plot training data
plot(X(:,1), y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
xlabel('Carat (x)');
ylabel('Price (y)');
%}
fprintf('Data Visualized. Press enter to continue.\n');
pause;

%% Sets up functions for training

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

%% More stuff






