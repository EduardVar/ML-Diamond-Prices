function g = sigmoid(z)
%SIGMOID Compute sigmoid functoon
%   J = SIGMOID(z) computes the sigmoid of z.

g = 1.0 ./ (1.0 + exp(-z)); % Normal Sigmoid
%g = tanh(z);                % Tanh activation function
%g = max(z, [], 2);          % ReLU activation function
end
