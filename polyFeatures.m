function [X_poly] = polyFeatures(X, p)
%POLYFEATURES 
%

%{
% Variables required
X_poly = zeros(numel(X), p);    % Matrix of polynomial features
m = size(X, 1); % Number of training examples

for i = 1:m,
    for j = 1:p,
       X_poly(i, j) = X(i) .^ j; 
    end
end
%}

% Variables required
m = size(X, 1); % Number of training examples
n = size(X, 2); % Number of original features

polyFeats = zeros(m, (n * (p-1)));

for i = 1:m,
    newPolyRow = [];
    
    for j = 1:n,
        for k = 2:p,
            newPolyRow = [newPolyRow X(i, j).^k];
        end
    end
    
    polyFeats(i, :) = newPolyRow(1, :);
end

X_poly = [X polyFeats];
disp(size(X_poly));


end
