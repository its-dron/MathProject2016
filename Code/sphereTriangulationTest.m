% Generate random points on a surface of a sphere, then attempt to
% triangulate the surface

%% Housekeeping
close all
clc
clear variables

debug = true;

%% Generate data
numPoints = 1000;
[sphereX, sphereY, sphereZ] = generatePointsOnSphere(numPoints, 2);

%% Triangulate - OUR CODE WILL GO HERE
dt = delaunayTriangulation(sphereX, sphereY, sphereZ);
[tri, X] = freeBoundary(dt);

%% Visualize
trisurf(tri, X(:,1), X(:,2), X(:,3));
axis equal