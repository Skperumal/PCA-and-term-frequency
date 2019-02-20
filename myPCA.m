% COMPUTE PCA
% Marking ID - 3084
function [U_principal,S_eigen]=myPCA(X)
cov_of_X = cov(X);
[V,D]=eig(cov_of_X);

[d,ind]=sort(diag(D),'descend');
U_principal=V(:,ind);
S_eigen=D(ind,ind);
end