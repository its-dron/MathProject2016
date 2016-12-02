%% Housekeeping
close all
clc
clear variables

debug = true;

%% Generate data
numPoints = 100;
[sphereX, sphereY, sphereZ] = generatePointsOnSphere(numPoints, 2);
X = [sphereX, sphereY, sphereZ];
scatter3(sphereX, sphereY, sphereZ);
axis equal

%% Run Matlab's Delaunay Triangulation

DT = delaunayTriangulation(X);
% trisurf(tri, DT.Points(:,1), DT.Points(:,1), DT.Points(:,1));
figure
tetramesh(DT);
axis equal