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
[ triangles ] = naiveDelaunay( x ,y );

%% Plot Triangles
nTriangles = length(triangles);

hold on
for i = 1:nTriangles
    pts2plot = triangles{i};
    pts2plot = [pts2plot; pts2plot(1,:)];
    line(pts2plot(:,1), pts2plot(:,2));
end