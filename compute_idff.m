%Marking ID - 3084
function I = compute_idff(X)
[m, n]=size(X);
I = zeros(m, n);
for j=1:n
    for i=1:m
        nz = nnz( X(i, :) );
        if nz ~= 0 
            I(i,j) = log( n / nz );
        end
    end
end
end