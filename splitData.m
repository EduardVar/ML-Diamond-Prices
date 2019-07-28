function [X, y, Xval, yval, Xtest, ytest] = splitData(data)
%SPLITDATA Summary of this function goes here
%   Detailed explanation goes here

% Initializes variables to be used in splitting data
mTotal = size(data, 1); % Total training examples in full data set
divider = int32(5); % Creates a 32-bit int for integer division
twentyPrecent = idivide(mTotal, divider);   % Finds index value for 20% of
                                            % the data set

% Creates indices for each training set start and stop 
% Splits data into 60/20/20 for training, CV, and test sets respectively 
trainSetEnd = twentyPrecent * 3;
valSetStart = trainSetEnd + 1;
valSetEnd = valSetStart + twentyPrecent - 1;
testSetStart = valSetEnd + 1;

% Shuffles data to randomize training examples
randomData = data(randperm(mTotal), :);

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

