function [Theta1, Theta2] = trainNN(costFunction, initial_nn_params, ...
                                    options, input_layer_size, ...
                                    hidden_layer_size, num_labels)
%TRAINNN Summary of this function goes here
%   Detailed explanation goes here

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

end

