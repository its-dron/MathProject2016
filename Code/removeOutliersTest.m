% Generate random points on a surface of a sphere, add noise

%% Housekeeping
close all
clc
clear variables

debug = true;

%% Generate data
numPoints = 1000;
r = 2;
X = generatePointsOnSphere(numPoints, r);

outliers = r*(2*rand(numPoints/20, 3) - 1);

X_noisy = [X; outliers];

%% Remove Outliers
X_cleaned = removeOutliers(X_noisy, 5, 5);

%% Visualize
scatter3(X_cleaned(:,1), X_cleaned(:,2), X_cleaned(:,3));
axis equal
hold on
scatter3(outliers(:,1), outliers(:,2), outliers(:,3), 'rx');
hold off
