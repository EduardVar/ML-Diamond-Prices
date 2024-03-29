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
data = data(1:7192, :);

% Uses function to split given data into training, CV, and test set
[X, y, Xval, yval, Xtest, ytest] = splitData(data);

m = size(X, 1);  % Stores number of training examples
n = size(X, 2); % Stores number of features

% Initializes parameters for training
theta = ones(n + 1, 1); % Sets theta to a matrix of ones (of features)
lambda = 1; % Sets lambda will be changed later
iter = 200;

fprintf('Program initialized. Press enter to continue.\n');
pause;

%% Normalize Data

disp("Normalizing Data ...");

[X, mu, sigma] = featureNormalize(X);

Xval = bsxfun(@minus, Xval, mu);
Xval = bsxfun(@rdivide, Xval, sigma);

Xtest = bsxfun(@minus, Xtest, mu);
Xtest = bsxfun(@rdivide, Xtest, sigma);

disp(X(1:5, :));
fprintf('Data Normalized. Press enter to continue.\n');
pause;

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

%% Add polynomial features

disp("Adding polynomial features ...");

% Map X onto Polynomial Features and Normalize
X_poly = quadraticFeatures(X);
%X_poly = cubicFeatures(X);
%X_poly = quarticFeatures(X);

[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
X_poly = [ones(length(X), 1), X_poly];                   % Add Ones

% Map X_poly_test and normalize (using mu and sigma)
X_poly_test = quadraticFeatures(Xtest);
%X_poly_test = cubicFeatures(Xtest);
%X_poly_test = quarticFeatures(Xtest);
X_poly_test = bsxfun(@minus, X_poly_test, mu);
X_poly_test = bsxfun(@rdivide, X_poly_test, sigma);
X_poly_test = [ones(size(X_poly_test, 1), 1), X_poly_test];         % Add Ones

% Map X_poly_val and normalize (using mu and sigma)
X_poly_val = quadraticFeatures(Xval);
%X_poly_val = cubicFeatures(Xval);
%X_poly_val = quarticFeatures(Xval);
X_poly_val = bsxfun(@minus, X_poly_val, mu);
X_poly_val = bsxfun(@rdivide, X_poly_val, sigma);
X_poly_val = [ones(size(X_poly_val, 1), 1), X_poly_val];           % Add Ones

fprintf('Normalized Training Example 1:\n');
fprintf('  %f  \n', X_poly(1, :));

fprintf('Adding polynomials complete. Press enter to continue.\n');
pause;

%% Fiding best lambda

disp("Finding the best theta ...");
[lambda_vec, error_train, error_val] = ...
    validationCurve(X_poly, y, X_poly_val, yval, iter);
%{
[lambda_vec, error_train, error_val] = ...
    validationCurve(X, y, Xval, yval, iter);
%}
close all;
plot(lambda_vec, error_train, lambda_vec, error_val);
legend('Train', 'Cross Validation');
xlabel('lambda');
ylabel('Error');

fprintf('lambda\t\tTrain Error\tValidation Error\n');
for i = 1:length(lambda_vec)
	fprintf(' %f\t%f\t%f\n', ...
            lambda_vec(i), error_train(i), error_val(i));
end

[value, index] = min(error_val);

lambda = lambda_vec(index)

fprintf('Optimal lambda found. Press enter to continue.\n');
pause;

%% TRAINS USING POLYNOMIAL FEATURES

[theta] = trainLinearReg(X_poly, y, lambda, iter);


%% TRAINS USING LINEAR
%{
[theta] = trainLinearReg(X, y, lambda, iter);
%}

%% Checking learning curve (polynomial regresssion)
%{
% Make sure theta is trained

[error_train, error_val] = ...
    learningCurve(X_poly, y, ...
                  X_poly_val, yval, ...
                  lambda, iter);

plot(1:m, error_train, 1:m, error_val);
title('Learning curve for polynomial regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
minY = min(error_val); % Stores maximum Y value for cross val set
axis([0 m 0 minY])

fprintf('Polynomial learning curve plotted. Press enter to continue.\n');
pause;
%}
%% Checking learning curve (linear regression)
%{
disp("Checking learning curve ...");

[error_train, error_val] = ...
    learningCurve([ones(m, 1) X], y, ...
                  [ones(size(Xval, 1), 1) Xval], yval, ...
                  lambda, iter);

plot(1:m, error_train, 1:m, error_val);
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
minY = min(error_val); % Stores minimum Y value for cross val set
axis([0 m 0 minY])

fprintf('Linear learning curve plotted. Press enter to continue.\n');
pause;
%}

%% Check overall performance cost (POLYNOMIAL)

disp("Calculating overall polynomial performance ...");

mTest = size(X_poly_test, 1);

[J, grad] = linearRegFunc([ones(mTest, 1) X_poly_test(:, 2:end)], ytest, theta, 0);
disp("Final cost with theta: " + J);

%% Check overall performance cost (LINEAR)
%{
disp("Calculating overall linear performance ...");

[J, grad] = linearRegFunc(Xtest, ytest, theta, 0);
disp("Final cost with theta: " + J);
%}

%% User input

% TEST [0.23 "Ideal" "E" "SI2" 61.5 55  3.95 3.98 2.43]
testExample = [0.23 5 6 2 61.5 55  3.95 3.98 2.43]; % Price should be 326

[testExample, mu, sigma] = featureNormalize(testExample);

example_poly = quadraticFeatures(testExample);

example_poly = bsxfun(@minus, example_poly, mu);
example_poly = bsxfun(@rdivide, example_poly, sigma);
example_poly = [ones(size(example_poly, 1), 1), example_poly];         % Add Ones


predictedPrice = example_poly * theta;

disp("The predicted price using this theta is: " + predictedPrice);

