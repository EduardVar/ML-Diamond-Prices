function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);

% SETUP DIFFERENT VERSIONS OF THETA
% Removes first column (no bias at all)
newTheta1 = Theta1(:, 2:end); 
newTheta2 = Theta2(:, 2:end);
% Replaces bias unit with zeroes (same size, no bias)
noBiasTheta1 = [zeros(size(Theta1,1), 1) Theta1(:, 2:end)];
noBiasTheta2 = [zeros(size(Theta2,1), 1) Theta2(:, 2:end)];
         
% Nneed to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% Part 1: Feedforward the neural network and return the cost in the
%         variable J.
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients


% Part 1: Feedforward the neural network and return the cost in J.

% Forward props until 3rd activation
a1 = X;
a1biased = [ones(m, 1) a1];
z2 = a1biased * Theta1';

a2 = sigmoid(z2);
a2biased = [ones(m, 1) a2];
z3 = a2biased * Theta2';

a3 = sigmoid(z3);
hyp = a3;

innerCost = (-y .* log(hyp)) - ((1 - y) .* log(1 - hyp));
kSum = sum(innerCost);  % k is label num (ex: 1, 2, 3... in classification)
innerReg = sum(sum(newTheta1.^2)) + sum(sum(newTheta2.^2)); % Adds reg

J = ((1/m) * sum(kSum)) + ((lambda/(2*m)) * innerReg);


% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad.

% deltas (d) are errors
d3 = a3 - y; 
d2 = d3 * newTheta2 .* sigmoidGradient(z2);

% Deltas (traingle) are sum of difference with previous layer's activation
Delta2 = d3' * a2biased; 
Theta2_grad = ((1/m) * Delta2) + ((lambda/m) * noBiasTheta2);

Delta1 = d2' * a1biased;
Theta1_grad = ((1/m) * Delta1) + ((lambda/m) * noBiasTheta1);


% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
