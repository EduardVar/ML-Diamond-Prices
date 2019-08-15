function [lambda_vec, error_train, error_val] = ...
    validationCurve(X, y, Xval, yval, initial_nn_params, options, ...
                    input_layer_size, hidden_layer_size, num_labels)
%VALIDATIONCURVE Generate the train and validation errors needed to
%plot a validation curve that we can use to select lambda
%   [lambda_vec, error_train, error_val] = ...
%       VALIDATIONCURVE(X, y, Xval, yval) returns the train
%       and validation errors (in error_train, error_val)
%       for different values of lambda. You are given the training set (X,
%       y) and validation set (Xval, yval).
%

% Selected values of lambda (you should not change this)
lambda_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10 30 100 300 1000 3000 10000 30000]';

% You need to return these variables correctly.
error_train = zeros(length(lambda_vec), 1);
error_val = zeros(length(lambda_vec), 1);

% Initializes zero lambda to be used in getting errors
zeroLam = 0;

for i = 1:length(lambda_vec),
    lambda = lambda_vec(i);
    
    
    costFunction = @(p) nnCostFunction(p, ...
                                       input_layer_size, ...
                                       hidden_layer_size, ...
                                       num_labels, X, y, lambda);
    
    
    % Finds the theta for all training sets with current lambda
    [Theta1, Theta2] = trainNN(costFunction, initial_nn_params, options, ...
                          input_layer_size, hidden_layer_size, num_labels);
    
    nn_params = [Theta1(:) ; Theta2(:)];

    % Gets error for whole training set
    [error_train(i), grad] = nnCostFunction(nn_params, ...
                                            input_layer_size, ...
                                            hidden_layer_size, ...
                                            num_labels, ...
                                            X, y, zeroLam);
    % Do it on the whole cross validation set
    [error_val(i), grad] = nnCostFunction(nn_params, ...
                                            input_layer_size, ...
                                            hidden_layer_size, ...
                                            num_labels, ...
                                            Xval, yval, zeroLam);

end

end
