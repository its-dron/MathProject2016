% Generate random points on a surface of a sinusoid, then attempt to
% triangulate the surface

%% Housekeeping
close all
clc
clear variables

%% Generate data
h = 10; w = 10;
numPoints = 300;
X = bsxfun(@times, rand(numPoints, 2), [w h]);
x = X(:,1); y = X(:,2);
z = .5*(sin(x) + cos(y));
X = [X, z];

%% Triangulate - OUR CODE WILL GO HERE
[tri] = alphaShape3D(x, y, z, .7);

%% Visualize
trisurf(tri, X(:,1), X(:,2), X(:,3));
axis equal