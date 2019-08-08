function [X_poly] = quarticFeatures(X)
%

% Variables required
m = size(X, 1); % Number of training examples
n = size(X, 2); % Number of original features

quartFeats = zeros(m, n.^4);

for i = 1:m,
    newPolyRow = [];
    
    for a = 1:n,
        for b = 1:n,
            for c = 1:n,
                for d = 1:n,
                    newPolyRow = [newPolyRow (X(i, a).*X(i, b).*X(i, c).*X(i, d))];
                end
            end
        end
    end
    
    quartFeats(i, :) = newPolyRow(1, :);
end

X_poly = [X quartFeats];

end
