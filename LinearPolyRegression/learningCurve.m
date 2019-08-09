function [error_train, error_val] = ...
    learningCurve(X, y, Xval, yval, lambda, iter)
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
    
    % Finds the theta for this specific training set
    setTheta = trainLinearReg(X(1:i, :), y(1:i), lambda, iter);

    % Do it on all of the sets trained on
    [error_train(i), trainIndicies] = linearRegFunc(X(1:i, :), y(1:i), setTheta, zeroLam);
    % Do it on the whole cross validation set
    [error_val(i), valIndicies] = linearRegFunc(Xval, yval, setTheta, zeroLam);
    
end

end


