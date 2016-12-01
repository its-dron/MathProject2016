% Generate random points on a surface of a sinusoid, then attempt to
% triangulate the surface

%% Housekeeping
close all
clc
clear variables

%% Generate data
ptCloud = pcread('teapot.ply');
data = ptCloud.Location;

nTargetPts = 300;
nOgPts = size(data,1);

%% Randomly select points from the pointcloud
pointSelector = randperm(nOgPts, nTargetPts);
x = data(pointSelector,1);
y = data(pointSelector,2);
z = data(pointSelector,3);

x = data(1:100:end,1);
y = data(1:100:end,2);
z = data(1:100:end,3);

%% Triangulate - OUR CODE WILL GO HERE
alpha = 0.7;
[tri] = alphaShape3D(x, y, z, alpha);

%% Visualize
figure;
scatter3(x,y,z);

figure;
trisurf(tri, x, y, z);
axis equal
title(sprintf('Alpha Shape, \\alpha = %.2f ', alpha));