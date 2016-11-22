% Generate random points on a surface of a sphere, then attempt to
% triangulate the surface

%% Housekeeping
close all
clc
clear variables

debug = true;

%% Generate data
numPoints = 1000;
X = generatePointsOnSphere(numPoints, 2);

%% Compute normals
N = estimateNormals(X, 5);

%% Visualize
scatter3(X(:,1), X(:,2), X(:,3));
axis equal
hold on
quiver3(X(:,1), X(:,2), X(:,3), N(:,1), N(:,2), N(:,3));
hold off
