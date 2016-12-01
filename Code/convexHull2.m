function [ polygon, v0 ] = convexHull2( coor )
%convexHull2 Calculates the convex hull of the input dataset.
%   coor is an n x 2 matrix where each row is an x,y pair
%
% Polygon attributes:
%   v      (n+1) x 2 matrix where each row is a vertex.  The line creating
%           the closed polygon is created clockwise (inside always to the 
%           right) by iterating through these datapoints.

%% Handle Input
nPoints = size(coor,1);

%% Find Extrema Points
% extrema points are first used to remove as many points as possible first
% the minX will be used to measure the relative angle of all remaining
% points.

[~, minLinIdx] = min(coor, [], 1);
[~, maxLinIdx] = max(coor, [], 1);
extremaLinIdx = [minLinIdx(:); maxLinIdx(:)];

%[minX; minY; maxX; maxY] <- a 4x2 matrix of the quadilatral vertices
vExtrema = coor(extremaLinIdx,:);

%% Remove all points within this quadrilateral
% (heuristic for speeding up calculations later)
nextVIdx = [2, 3, 4, 1];
coorToRemoveMask = true(nPoints, 1);
coorToRemoveMask(extremaLinIdx) = false;
for i = 1:4
    coorToRemoveMask(coorToRemoveMask) =  isLeft(coor(coorToRemoveMask, :),...
                                            vExtrema(i, :), ...
                                            vExtrema(nextVIdx(i), :)) > 0;
end
%debug
% coorToRemoveMask = false(nPoints, 1);
coorToRemoveMask(extremaLinIdx(1)) = true; %remove the primary vertex

%% Sort points by angle
%sort all remaining points but v0 relative to v0
sortedCoor = mergesort(coor(~coorToRemoveMask,:), vExtrema(1,:));

%% Assemble Hull
[ hullPts ] = assembleHull(sortedCoor, vExtrema(1,:));

%% Package Output
polygon.v = hullPts;
end