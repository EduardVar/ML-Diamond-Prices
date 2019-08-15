function [accuracy, error] = calcAccuracy(Theta1, Theta2, Xtest, ytest)
%CALCACCURACY Summary of this function goes here
%   Detailed explanation goes here

m = size(Xtest, 1);

a1 = Xtest;
a1biased = [ones(m, 1) a1];
z2 = a1biased * Theta1';

a2 = sigmoid(z2);
a2biased = [ones(m, 1) a2];
z3 = a2biased * Theta2';

predPrices = z3;


differences = abs((predPrices ./ ytest) - 1);
percentError = sum(differences) / m;
accuracy = (1 - percentError) * 100;

error = ((sum(ytest - predPrices).^2)/m ) .^ (1/2);

end

