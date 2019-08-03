function [X_poly] = quadraticFeatures(X, p)
%

% Variables required
m = size(X, 1); % Number of training examples
n = size(X, 2); % Number of original features

quadFeats = zeros(m, n.^2);

for i = 1:m,
    newPolyRow = [];
    
    for j = 1:n,
        for k = 1:n,
            newPolyRow = [newPolyRow (X(i, j).*X(i, k))];
        end
    end
    
    quadFeats(i, :) = newPolyRow(1, :);
end

X_poly = [X quadFeats];
disp(size(X_poly));


end
