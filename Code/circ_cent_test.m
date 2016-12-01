%% Housekeeping
close all
clc
clear variables

%% Generate 2D Points
coor = rand(2,2);
x=coor(:,1);
y=coor(:,2);

%% Run
R = 2;
[C]=circ_cent(coor(1,:), coor(2,:), R)

%% Plot 2D points
figure;
scatter(coor(:,1), coor(:,2));
hold on
viscircles(C(1,:),R);
viscircles(C(2,:),R);