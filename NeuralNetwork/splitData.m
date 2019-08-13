function [X, y] = splitData(data)
%SPLITDATA Summary of this function goes here
%   Detailed explanation goes here

m = size(data, 1);

% Shuffles data to randomize training examples
randomData = data(randperm(m), :);
%randomData = data;



% Splits each set into the X and y matrices
y = randomData(:, 7);
X = [randomData(:, 1:6) randomData(:, 8:10)];

end

