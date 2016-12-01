%% Housekeeping
close all
clc
clear variables

%% Generate 2D Points
coor = rand(20,2);
x=coor(:,1);
y=coor(:,2);
%% Plot 2D points
figure;
scatter(coor(:,1), coor(:,2))

%% Run Delaunay
% [ triangles ] = edgeFlipDelaunay( x ,y )
[ triangles ] = edgeFlipDelaunay( x ,y )