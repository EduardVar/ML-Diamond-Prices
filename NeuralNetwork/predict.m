function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)


m = size(X, 1);

a1 = X;
a1biased = [ones(m, 1) a1];
z2 = a1biased * Theta1';

a2 = sigmoid(z2);
a2biased = [ones(m, 1) a2];
z3 = a2biased * Theta2';

p = z3;

% =========================================================================


end
