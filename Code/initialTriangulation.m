function [ keptEdges ] = initialTriangulation( x,y )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

nPoints = size(x,1);
nEdges = nPoints * (nPoints-1) / 2;
coor = [x,y];

%% Generate all edges
allEdges = zeros(nEdges,4);
idx = 0;
for i = 1:nPoints-1
    for j = i+1:nPoints
        idx = idx + 1;
        allEdges(idx,:) = [x(i), y(i), x(j), y(j)];
    end
end


%% Add Edges
keptEdges = zeros(size(allEdges));
keptEdges(1,:) = allEdges(1,:);
nKeptEdges = 1;
for i = 2:nEdges-1
    intersect = false;
    for j = 1:nKeptEdges
        res = doesIntersect(allEdges(i,1:2), allEdges(i,3:4), ...
                            keptEdges(j,1:2), keptEdges(j,3:4), 1e-3);
        if res
            intersect = true;
            break;
        end
    end
    
    if ~intersect
        nKeptEdges = nKeptEdges + 1;
        keptEdges(nKeptEdges,:) = allEdges(i,:);
    end
end
keptEdges = keptEdges(1:nKeptEdges,:);


%% Debug Plot
nTriEdges = size(keptEdges,1);
figure;
scatter(x,y);
hold on
for i = 1:nTriEdges
    line(keptEdges(i,[1,3]),keptEdges(i,[2,4]));
end

end

