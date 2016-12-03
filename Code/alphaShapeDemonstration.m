%Housekeeping
clear variables
close all
clc

%% Generate test data
letter = 'B';
datasetName = [letter,'.mat'];
nPoints = 70;
axisRange = [1 3 1.8 4.1];%[0, 5, 0, 5];
if exist(datasetName, 'file')
    load(datasetName, 'x', 'y', 'axisRange');
else
    figure;
    axis(axisRange);
    hold on
    x = zeros(nPoints,1);
    y = zeros(nPoints,1);
    for i = 1:nPoints
        [x(i),y(i)] = ginput(1);
        scatter(x(i),y(i));
        drawnow
    end
    
    save(datasetName, 'x', 'y', 'axisRange');
end
axisRange = [1 3 1.8 4.1];%[0, 5, 0, 5];

% add a small amount of random noise to each datapoint
x = x + 0.001*(rand(size(x))-0.5);
y = y + 0.001*(rand(size(y))-0.5);

%% Plot
figure;
subplot(161)
scatter(x,y);
title(sprintf('Datapoints Constituting a "%s"', letter));
axis(axisRange);
axis square

%% Convex Hull
subplot(162)
scatter(x,y);
title(sprintf('Convex Hull of a "%s"',letter));
axis(axisRange);
axis square
hold on;
poly = convexHull2( [x,y] );
line([poly.v(:,1); poly.v(1,1)], ...
     [poly.v(:,2); poly.v(1,2)], 'Color', 'r');
 
%% Alpha shape
alpha = 0.2;
[ edges ] = alphaShape2D( x,y, alpha );
nEdges = length(edges);

subplot(165)
scatter(x,y);
% title(sprintf('Alpha Shape, \\alpha = %.2f ', alpha));
axis(axisRange);
axis square
hold on

for i = 1:nEdges
    lineToPlot = edges{i};
    line(lineToPlot(1,[1,3]), lineToPlot(1,[2,4]), ...
         'Color', 'r');
end

%% Alpha shape
alpha = 0.4;
[ edges ] = alphaShape2D( x,y, alpha );
nEdges = length(edges);

subplot(164)
scatter(x,y);
% title(sprintf('Alpha Shape, \\alpha = %.2f ', alpha));
axis(axisRange);
axis square
hold on

for i = 1:nEdges
    lineToPlot = edges{i};
    line(lineToPlot(1,[1,3]), lineToPlot(1,[2,4]), ...
         'Color', 'r');
end

%% Alpha shape
alpha = 3;
[ edges ] = alphaShape2D( x,y, alpha );
nEdges = length(edges);

subplot(163)
scatter(x,y);
% title(sprintf('Alpha Shape, \\alpha = %.2f ', alpha));
axis(axisRange);
axis square
hold on

for i = 1:nEdges
    lineToPlot = edges{i};
    line(lineToPlot(1,[1,3]), lineToPlot(1,[2,4]), ...
         'Color', 'r');
end
