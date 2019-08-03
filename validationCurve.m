function [lambda_vec, error_train, error_val] = ...
    validationCurve(X, y, Xval, yval, iter)
%VALIDATIONCURVE Generate the train and validation errors needed to
%plot a validation curve that we can use to select lambda
%   [lambda_vec, error_train, error_val] = ...
%       VALIDATIONCURVE(X, y, Xval, yval) returns the train
%       and validation errors (in error_train, error_val)
%       for different values of lambda. You are given the training set (X,
%       y) and validation set (Xval, yval).
%

% Selected values of lambda (you should not change this)
%lambda_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10]';
lambda_vec = [0 0.000001 0.000003 0.00001 0.00003 0.0001 0.0003 0.001 0.003 0.01 0.03 0.1 0.3]';
%lambda_vec = 0:0.001:0.1;

% You need to return these variables correctly.
error_train = zeros(length(lambda_vec), 1);
error_val = zeros(length(lambda_vec), 1);

% Initializes zero lambda to be used in getting errors
zeroLam = 0;

%for i = 1:length(lambda_vec)
for i = 1:length(lambda_vec),
    lambda = lambda_vec(i);
    
    % Finds the theta for all training sets with current lambda
    setTheta = trainLinearReg(X, y, lambda, iter);

    % Gets error for whole training set
    [error_train(i), grad] = linearRegFunc(X, y, setTheta, zeroLam);
    % Do it on the whole cross validation set
    [error_val(i), grad] = linearRegFunc(Xval, yval, setTheta, zeroLam);

end

% =========================================================================

end
