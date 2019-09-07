function g = sigmoidGradient(z)
%SIGMOIDGRADIENT returns the gradient of the sigmoid function
%evaluated at z
%   g = SIGMOIDGRADIENT(z) computes the gradient of the sigmoid function
%   evaluated at z. This should work regardless if z is a matrix or a
%   vector. In particular, if z is a vector or matrix, you should return
%   the gradient for each element.

g = sigmoid(z) .* (1 - sigmoid(z)); % Sigmoid gradient Descent
%g = 1 - (sigmoid(z)).^2;            % Tanh descent
%{
if z < 0                            % ReLU gradient descent
    g = 0;
else
    g = z;
%}
end
