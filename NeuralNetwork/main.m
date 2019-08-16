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
data = data(1:2000, :);

%% Normalize Data (before)
%{
yColumn = data(:, 7);
allX = [data(:, 1:6) data(:, 8:10)];

[allX, mu, sigma] = featureNormalize(allX);

disp(size(yColumn(:, 1)));
disp(size(allX));

data = [allX(:, 1:6) yColumn(:, 1) allX(:, 7:end)];
disp(size(data));
%}
%% Split Data
% Uses function to split given data into training, CV, and test set
[X, y, Xval, yval, Xtest, ytest] = splitData(data);

disp("Checks the first five rows X ...");
disp(X(1:5, :))

fprintf('Data loaded and stored. Press enter to continue.\n');

%% Normalize Data

fprintf("\nNormalizing Data ...\n");

[X, mu, sigma] = featureNormalize(X);

Xval = bsxfun(@minus, Xval, mu);
Xval = bsxfun(@rdivide, Xval, sigma);

Xtest = bsxfun(@minus, Xtest, mu);
Xtest = bsxfun(@rdivide, Xtest, sigma);

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

fprintf('\nAdding polynomials complete. Press enter to continue.\n');
%pause;
%}
%% Initialization

fprintf("\nInitializing program ...");

[m, n] = size(X);  % Stores number of training examples m and features n

% Initializes parameters for training
input_layer_size  = n;  % n Input Features (can extend with POLYNOMIALS)
hidden_layer_size = 128;   % 128 hidden units
num_labels = 1;          % 1 output label (price)  

%options = optimset('MaxIter', 100);  % Increase iters for more training!
%lambda = 1; % WILL NEED TO TEST FOR TRAINING


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

%% Finding best lambda

fprintf("\nFinding the best theta ...\n");

options = optimset('MaxIter', 50);

[lambda_vec, error_train, error_val] = ...
    validationCurve(X, y, Xval, yval, initial_nn_params, options, ...
                    input_layer_size, hidden_layer_size, num_labels);


fprintf('lambda\t\tTrain Error\tValidation Error\n');
for i = 1:length(lambda_vec)
	fprintf(' %f\t%f\t%f\n', ...
            lambda_vec(i), error_train(i), error_val(i));
end

[value, index] = min(error_val);

lambda = lambda_vec(index);

fprintf('\nOptimal lambda - %f - found.\n', lambda);
%pause;

%% Sets up functions for training

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);
                               
%% Train Neural Network

fprintf("\nTraining neural network ...\n");

options = optimset('MaxIter', 100);

[Theta1,Theta2] = trainNN(costFunction, initial_nn_params, options, ...
                          input_layer_size, hidden_layer_size, num_labels);

             
fprintf('Neural network trained. Press enter to continue.\n');
%pause;

%% Checking learning curve 

disp("Checking learning curve ...");

[error_train, error_val] = ...
    learningCurve(X, y, Xval, yval, initial_nn_params, options, ...
                    input_layer_size, hidden_layer_size, num_labels, lambda);

plot(1:m, error_train, 1:m, error_val);
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
minY = min(error_val); % Stores minimum Y value for cross val set
axis([0 m 0 minY])

fprintf('Linear learning curve plotted. Press enter to continue.\n');
pause;

             
%% Check prediction accuracy

[accuracy, error] = calcAccuracy(Theta1, Theta2, Xtest, ytest);

prediction = predict(Theta1, Theta2, Xtest);

fprintf('Predicted\t\tCalculated\tActual Price\n');
for i = 1:length(prediction)
	fprintf(' %d\t%f\t%d\n', ...
            i, prediction(i), ytest(i));
end

fprintf('\nAccuracy is: %f%c\nError is: %f\n', accuracy, '%', error);
fprintf('\nLambda was: %f\n', lambda);
