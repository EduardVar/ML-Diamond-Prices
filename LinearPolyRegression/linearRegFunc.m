function [J, grad] = linearRegFunc(X, y, theta, lambda)
%LINEARREGFUNC Compute cost and gradient for regularized linear regression 
%with multiple variables
%   [J, grad] = LINEARREGFUNC(X, y, theta, lambda) computes the cost of 
%   using theta as the parameter for linear regression to fit the data 
%   points in X and y. Returns the cost in J and the gradient in grad

%% Initializes variables
m = length(y);  % Stores number of training examples
J = 0;  % Stores cost at current theta state
grad = zeros(size(theta));  % Stores gradient at current theta state

%% Computes cost and gradient of regularized linear regression for choice theta.

hypothesis = X * theta; % Calculates the hypothesis for choice theta

% Creates a new theta that doesn't contain the bais value
noBiasTheta = theta;
noBiasTheta(1) = 0;

% Vectorizes cost calculation using J equation, adds regularization to it
costSum = (1/(2*m)) * sum((hypothesis - y) .^ 2);
costReg = (lambda/(2*m)) * sum(noBiasTheta .^ 2);
J = costSum + costReg;

% Vectorizes cost calculation using J equation, adds regularization to it
gradSum = (1/m) * sum((hypothesis - y) .* X);
gradReg = (lambda/m) * noBiasTheta';
grad = gradSum + gradReg;

% DOCUMENTAIOTAITRAQRaOSEDANSOAWs
grad = grad(:);

end

