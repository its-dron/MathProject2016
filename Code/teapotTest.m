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
alpha = 0.45;
[tri, sphereCenters] = alphaShape3D(x, y, z, alpha);

%% Visualize
% figure;
% scatter3(x,y,z);

figure;
trisurf(tri, x, y, z);
axis equal
title(sprintf('Alpha Shape, \\alpha = %.2f ', alpha));

%% Visualize an example sphere
hold on
if exist('h')==1
    delete(h);
end
sphereOpacity = 1;
iSphereToPlot = randi(size(sphereCenters,1));

[ssX, ssY, ssZ] = sphere;
ssX = ssX * alpha;
ssY = ssY * alpha;
ssZ = ssZ * alpha;

sphereToPlotCenter = sphereCenters(iSphereToPlot, :);

h = surf(ssX + sphereToPlotCenter(1), ...
         ssY + sphereToPlotCenter(2), ...
         ssZ + sphereToPlotCenter(3), ...
         'EdgeColor','none','LineStyle','none','FaceLighting','phong', ...
         'FaceColor', 'r');
%delete(h); %if its not cool;
set(h, 'FaceAlpha', sphereOpacity)
% shading interp