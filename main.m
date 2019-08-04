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

%% Add polynomial features

disp("Adding polynomial features ...");

% What degree of polynomial to add on 
p = 2;

% Map X onto Polynomial Features and Normalize
%X_poly = polyFeatures(X, p);
X_poly = quadraticFeatures(X);
%X_poly = cubicFeatures(X);

[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
X_poly = [ones(length(X), 1), X_poly];                   % Add Ones

% Map X_poly_test and normalize (using mu and sigma)
%X_poly_test = polyFeatures(Xtest, p);
X_poly_test = quadraticFeatures(Xtest);
%X_poly_test = cubicFeatures(Xtest);
X_poly_test = bsxfun(@minus, X_poly_test, mu);
X_poly_test = bsxfun(@rdivide, X_poly_test, sigma);
X_poly_test = [ones(size(X_poly_test, 1), 1), X_poly_test];         % Add Ones

% Map X_poly_val and normalize (using mu and sigma)
%X_poly_val = polyFeatures(Xval, p);
X_poly_val = quadraticFeatures(Xval);
%X_poly_val = cubicFeatures(Xval);
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

%% Checking learning curve (polynomial regresssion)
%{
[theta] = trainLinearReg(X_poly, y, lambda, iter);

[error_train, error_val] = ...
    learningCurve(X_poly, y, ...
                  X_poly_val, yval, ...
                  lambda, iter);

plot(1:m, error_train, 1:m, error_val);
title('Learning curve for linear regression')
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

[theta] = trainLinearReg(X, y, lambda, iter);

%lambda = 1;
[error_train, error_val] = ...
    learningCurve([ones(m, 1) X], y, ...
                  [ones(size(Xval, 1), 1) Xval], yval, ...
                  lambda, iter);

plot(1:m, error_train, 1:m, error_val);
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
maxY = max(error_train); % Stores maximum Y value for cross val set
axis([0 m 0 maxY])

fprintf('Linear learning curve plotted. Press enter to continue.\n');
pause;
%}

%% Check overall performance cost (POLYNOMIAL)


disp("Calculating overall performance ...");

mTest = size(X_poly_test, 1);

[J, grad] = linearRegFunc([ones(mTest, 1) X_poly_test(:, 2:end)], ytest, theta, lambda);
disp("Final cost with theta: " + J);

%% Check overall performance cost (LINEAR)
%{
disp("Calculating overall performance ...");

mTest = size(Xtest, 1);

[J, grad] = linearRegFunc([ones(mTest, 1) Xtest], ytest, theta, lambda);
disp("Final cost with theta: " + J);
%}

%% User input







