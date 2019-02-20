% Implementation of PCA part 1,2
% Marking ID- 3084

%Load data from file
X=load('pcadata.mat');

%PART -1
%Data Points and there canonical components
figure;
plot(X.X(:,1),X.X(:,2),'bo')
title('Datapoints and there 2 principal components')
xlim([0,7]);
ylim([2,8]);
[Xmu,mu]=subtractMean(X.X);
[U,S]=myPCA(Xmu);
line([0 U(1,1)] + mu(1,1), [0 U(2,1)] + mu(1,2), 'Color', 'r','LineWidth',2);
line([0 U(1,2)] + mu(1,1), [0 U(2,2)] + mu(1,2), 'Color', 'g','LineWidth',2);

%Data points and there reconstruction
Umu = bsxfun(@plus,U,mu);
K=1;
%reconstruct by projection of Xmu and recovering of data points with k=1
Z=projectData(Xmu,U,K);
rec_X = recoverData(Z, U, K, mu);
figure;
plot(X.X(:,1),X.X(:,2),'bo');
title('Datapoints and there reconstruction')
xlim([0,7]);
ylim([2,8]);
hold on
plot(rec_X(:,1),rec_X(:,2),'r*');

%PART 2
%displaying facesdata by subtracting mean and using PCA with k=200
X = load('pcafaces.mat');
figure;
displayData(X.X(1:100, :));
[Xmu,mu]=subtractMean(X.X);
[U,S]=myPCA(Xmu);
K=200;
Z=projectData(Xmu,U,K);

%Using recovered data and displaying both face dataset
figure;
subplot(1,2,1),displayData(X.X(1:100, :));
title('Original Faces')

rec_X = recoverData(Z, U, K, mu);
subplot(1,2,2),displayData(rec_X(1:100, :));
title('Recovered Faces')