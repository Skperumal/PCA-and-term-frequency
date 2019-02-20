%Marking ID - 3084
function X = compute_ttf(X)
for j=1:size(X, 2)
    for i=1:size(X, 1)
        x = X(:, j);
        sumX = sum(x);
        if sumX ~= 0
            X(:, j) = x / sum(x);
        else
            X(:, j) = 0;
        end
    end
end
end