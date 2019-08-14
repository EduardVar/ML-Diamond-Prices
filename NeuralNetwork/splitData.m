function [X, y, Xtest, ytest] = splitData(data)
%SPLITDATA Summary of this function goes here
%   Detailed explanation goes here

m = size(data, 1);

% Shuffles data to randomize training examples
randomData = data(randperm(m), :);
%randomData = data;

% Initializes variables to be used in splitting data
mTotal = size(data, 1); % Total training examples in full data set
divider = int32(5); % Creates a 32-bit int for integer division
twentyPrecent = idivide(m, divider);   % Finds index value for 20% of
                                        % the data set
                                            
trainSetEnd = twentyPrecent * 4;
testSetStart = trainSetEnd + 1;

trainingSet = randomData(1:trainSetEnd, :);
testSet = randomData(testSetStart:end, :);

% Splits each set into the X and y matrices
y = trainingSet(:, 7);
X = [trainingSet(:, 1:6) trainingSet(:, 8:10)];
ytest = testSet(:, 7);
Xtest = [testSet(:, 1:6) testSet(:, 8:10)]; 

end

