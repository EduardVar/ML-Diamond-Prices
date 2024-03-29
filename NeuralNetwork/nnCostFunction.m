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

%a3 = sigmoid(z3);
%a3 = z3;
hyp = z3;

costSum = (1/(2*m)) * sum((hyp - y) .^ 2);
costReg = sum(sum(newTheta1.^2)) + sum(sum(newTheta2.^2)); % Adds reg
J = costSum + (lambda/(2*m)) * costReg;


% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad.


% deltas (d) are errors
d3 = z3 - y; 
d2 = d3 * newTheta2 .* sigmoidGradient(z2);

% Deltas (traingle) are sum of difference with previous layer's activation
Delta2 = d3' * a2biased; 
Delta1 = d2' * a1biased;

%{
fprintf("\nd3: [%d %d]\n", size(d3, 1), size(d3, 2));
fprintf("\nX: [%d %d]\n", size(X, 1), size(X, 2));
fprintf("\nd3 .* X: [%d %d]\n", size((d3 .* X), 1), size((d3 .* X), 2));
fprintf("\nsum(d3 .* X): [%d %d]\n", size(sum(d3 .* X), 1), size(sum(d3 .* X), 2));
fprintf("FIRST\n");

Theta2sum = (1/m) * sum(d3 .* X);
Theta2deriv = (lambda/m) * noBiasTheta2';

fprintf("\nTheta2sum: [%d %d]\n", size(Theta2sum, 1), size(Theta2sum, 2));
fprintf("\nTheta2deriv: [%d %d]\n", size(Theta2deriv, 1), size(Theta2deriv, 2));
fprintf("SECOND\n");

Theta2_grad = (Theta2sum + Theta2deriv)';

fprintf("\nMy Theta2_grad: [%d %d]\n", size(Theta2_grad, 1), size(Theta2_grad, 2));
%}

Theta2_grad = ((1/m) * Delta2) + ((lambda/m) * noBiasTheta2);
Theta1_grad = ((1/m) * Delta1) + ((lambda/m) * noBiasTheta1);

%{
fprintf("\nLogistic Theta2_grad: [%d %d]\n", size(Theta2_grad, 1), size(Theta2_grad, 2));
fprintf("\nLogistic Theta1_grad: [%d %d]\n", size(Theta1_grad, 1), size(Theta1_grad, 2));
fprintf("END");
pause;
%}

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
