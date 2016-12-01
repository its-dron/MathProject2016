function [ triangles ] = edgeFlipDelaunay( x,y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

nPoints = size(x,1);
coor = [x,y];

%% Some initial Triangulation
[ initialEdges ] = initialTriangulation( x,y );
nInitialEdges = size(initialEdges,1);
edgeStart = initialEdges(:,1:2);
edgeEnd = initialEdges(:,3:4);

%% Get Convex Hull
polygon = convexHull2( coor );
hullPts = polygon.v;
nHullPts = size(hullPts,1);

%% Mark all hull which must not be shared
sharedEdges = true(nInitialEdges,1);
for i = 1:nHullPts-1
    [~, loc1] = ismember(hullPts(i,:), edgeStart, 'rows');
    [~, loc2] = ismember(hullPts(i+1,:), edgeEnd, 'rows');
    
    [~, loc3] = ismember(hullPts(i,:), edgeEnd, 'rows');
    [~, loc4] = ismember(hullPts(i+1,:), edgeStart, 'rows');
    if loc1==loc2 || loc3==loc4
        sharedEdges(i) = false;
    end
end

% newTriangleSet = 0;
% 
% traingles = cell(nHullPts,1);
% %select one non hull point
% for i = 1:nPoints
%     if ~any(hullPts==coor)
%         for j = 1:nHullPts
%             triangles{j}.v = 
%         end
%     end
% end

end
