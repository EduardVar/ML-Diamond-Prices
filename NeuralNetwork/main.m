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

% REDUCES DATA to X examples for testing purposes
data = data(1:5000, :);

% Uses function to split given data into training, CV, and test set
[X, y, Xval, yval, Xtest, ytest] = splitData(data);

disp("Checks the first five rows X ...");
disp(X(1:5, :))

fprintf('Data loaded and stored. Press enter to continue.\n');

%% Normalize Data

fprintf("\nNormalizing Data ...\n");

[X, mu, sigma] = featureNormalize(X);

fprintf('Data Normalized.\n');
%pause;

%% Add polynomial features
%{
fprintf("\nAdding polynomial features ...");

X = quadraticFeatures(X);
[X, mu, sigma] = featureNormalize(X);  % Normalize

Xval = quadraticFeatures(Xval);
Xval = bsxfun(@minus, Xval, mu);
Xval = bsxfun(@rdivide, Xval, sigma);

Xtest = quadraticFeatures(Xtest);
Xtest = bsxfun(@minus, Xtest, mu);
Xtest = bsxfun(@rdivide, Xtest, sigma);

fprintf('Adding polynomials complete. Press enter to continue.\n');
%pause;
%}
%% Initialization

fprintf("\nInitializing program ...");

[m, n] = size(X);  % Stores number of training examples m and features n

% Initializes parameters for training
input_layer_size  = n;  % n Input Features (can extend with POLYNOMIALS)
hidden_layer_size = 100;   % 200 hidden units
num_labels = 1;          % 1 output label (price)  

options = optimset('MaxIter', 100);  % Increase iters for more training!
lambda = 10; % WILL NEED TO TEST FOR TRAINING


fprintf('\nInitializing Neural Network Parameters ...\n')
% Randomely initializes thetas
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


fprintf('Program initialized. Press enter to continue.\n');
%pause;

%% Visualize Data

%qqplot(X); % Draws a QQ plot to see how data fits

fprintf('Data Visualized. Press enter to continue.\n');
%pause;

%% Sets up functions for training

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

%% Find best lambda
                               
%% Train Neural Network

fprintf("\nTraining neural network ...\n");

[Theta1,Theta2] = trainNN(costFunction, initial_nn_params, options, ...
                           input_layer_size, hidden_layer_size, num_labels);
             
fprintf('Neural network trained. Press enter to continue.\n');
%pause;
             
%% Check prediction accuracy

[accuracy] = calcAccuracy(Theta1, Theta2, Xtest, ytest, false);

prediction = predict(Theta1, Theta2, Xtest(1, :));
fprintf('\nPredicted: %f\nReal: %f\n', prediction, ytest(1, :));

fprintf('\nError is: %f\n', accuracy);

