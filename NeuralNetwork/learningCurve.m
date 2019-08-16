function [error_train, error_val] = ...
    learningCurve(X, y, Xval, yval, initial_nn_params, options, ...
                    input_layer_size, hidden_layer_size, num_labels, lambda)
%LEARNINGCURVE Generates the train and cross validation set errors needed 
%to plot a learning curve
%   [error_train, error_val] = ...
%       LEARNINGCURVE(X, y, Xval, yval, lambda) returns the train and
%       cross validation set errors for a learning curve. In particular, 
%       it returns two vectors of the same length - error_train and 
%       error_val. Then, error_train(i) contains the training error for
%       i examples (and similarly for error_val(i)).

% Number of training examples
m = size(X, 1);

% Error amounts for the training and validation set
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

% Used to store a zero value to sub into error lambdas
zeroLam = 0;

for i = 1:m,
    
    disp(i);
    
    costFunction = @(p) nnCostFunction(p, ...
                                       input_layer_size, ...
                                       hidden_layer_size, ...
                                       num_labels, ...
                                       X(1:i, :), y(1:i), lambda);
    
    % Finds the theta for this specific training set
    [Theta1, Theta2] = trainNN(costFunction, initial_nn_params, options, ...
                          input_layer_size, hidden_layer_size, num_labels);
                      
    % Sets trained thetas
    nn_params = [Theta1(:) ; Theta2(:)];

    % Do it on all of the sets trained on
    [error_train(i), grad] = nnCostFunction(nn_params, ...
                                            input_layer_size, ...
                                            hidden_layer_size, ...
                                            num_labels, ...
                                            X(1:i, :), y(1:i), zeroLam);
    % Do it on the whole cross validation set
    [error_val(i), grad] = nnCostFunction(nn_params, ...
                                            input_layer_size, ...
                                            hidden_layer_size, ...
                                            num_labels, ...
                                            Xval, yval, zeroLam);
    
end

end


