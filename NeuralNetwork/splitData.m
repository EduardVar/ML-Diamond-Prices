function [X, y, Xval, yval, Xtest, ytest] = splitData(data, distriPercent)
%SPLITDATA Summary of this function goes here
%   Detailed explanation goes here

% Creates helpful variables
m = size(data, 1);
testPercent = 100 - (2 * distriPercent);

% Stores index amount in 1% of all data indecies
percentChunck = idivide(m, int32(100));

% Shuffles data to randomize training examples
randomData = data(randperm(m), :);
%randomData = data;

% Creates indices for each training set start and stop 
% Splits data into (100-2dP)/dP/dP for training, CV, and test sets
trainSetEnd = percentChunck * testPercent;
valSetStart = trainSetEnd + 1;
valSetEnd = valSetStart + (percentChunck * distriPercent) - 1;
testSetStart = valSetEnd + 1;

% Creates the sets using indices calculates previously
trainingSet = randomData(1:trainSetEnd, :);
validationSet = randomData(valSetStart:valSetEnd, :);
testSet = randomData(testSetStart:end, :);

% Splits each set into the X and y matrices
y = trainingSet(:, 7);
X = [trainingSet(:, 1:6) trainingSet(:, 8:10)];
yval = validationSet(:, 7);
Xval = [validationSet(:, 1:6) validationSet(:, 8:10)];
ytest = testSet(:, 7);
Xtest = [testSet(:, 1:6) testSet(:, 8:10)]; 

end

