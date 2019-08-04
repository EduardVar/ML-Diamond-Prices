function [X_poly] = cubicFeatures(X)
%

% Variables required
m = size(X, 1); % Number of training examples
n = size(X, 2); % Number of original features

cubeFeats = zeros(m, n.^3);

for i = 1:m,
    newPolyRow = [];
    
    for a = 1:n,
        for b = 1:n,
            for c = 1:n,
                newPolyRow = [newPolyRow (X(i, a).*X(i, b).*X(i, c))];
            end
        end
    end
    
    cubeFeats(i, :) = newPolyRow(1, :);
end

X_poly = [X cubeFeats];

end
