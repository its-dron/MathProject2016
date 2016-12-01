function [ hullPts ] = assembleHull(sortedCoor, v0)
%ASSEMBLEHULL Selects the hull pts of the sortedCoor.
%   note: v0 is the first row of hullPts

hullPts = zeros(size(sortedCoor));
hullPts(1,:) = v0;
hullPts(2,:) = sortedCoor(1,:);
hullCounter = 2;

for i = 2:size(sortedCoor,1)
    res = isLeft(sortedCoor(i,:), hullPts(hullCounter - 1,:), ...
                                  hullPts(hullCounter,:));
    while res > 0
        hullCounter = hullCounter - 1;
        res = isLeft(sortedCoor(i,:), hullPts(hullCounter - 1,:), ...
                                      hullPts(hullCounter,:));
    end
    hullCounter = hullCounter + 1;
    hullPts(hullCounter,:) = sortedCoor(i,:);
end
hullPts = hullPts(1:hullCounter, :);
end

