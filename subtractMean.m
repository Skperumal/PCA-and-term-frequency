% SUBTRACT MEAN
% Marking ID- 3084
function [Xmu,mu]=subtractMean(X)
mu=mean(X);
Xmu = bsxfun(@minus,X,mu);
end