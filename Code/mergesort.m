function sortedCoordinates = mergesort(coordinates, v0)
%%MERGESORT specifically for coordinates left to right relative to v0
% sorted in terms of left most to right most (relative to angle with v0)

    nPoints = size(coordinates,1);
    if  nPoints > 1
        midPt = floor((1+nPoints) / 2);
        
        sortedSubset1 = mergesort(coordinates(1:midPt,:), v0);
        sortedSubset2 = mergesort(coordinates(midPt+1:nPoints,:), v0);
        
        i1 = 1;
        nSortedSubset1 = size(sortedSubset1,1);
        i2 = 1;
        nSortedSubset2 = size(sortedSubset2,1);
        sortedCoordinates = zeros(nSortedSubset1 + nSortedSubset2, 2);

        nDeleted = 0;
        for i = 1:nPoints
            %% Early Escape
            if i1 > nSortedSubset1 && i2 > nSortedSubset2
                break;
            end
            if i1 > nSortedSubset1
                sortedCoordinates(i:end-nDeleted, :) = ...
                    sortedSubset2(i2:end,:);
                break;
            end
            if i2 > nSortedSubset2
                sortedCoordinates(i:end-nDeleted, :) = ...
                    sortedSubset1(i1:end,:);
                break;
            end
            
            %% Compute Which is left
            res = isLeft(sortedSubset1(i1,:), v0, sortedSubset2(i2,:));
            if res>0
                sortedCoordinates(i, :) = sortedSubset1(i1,:);
                i1 = i1 + 1;
            elseif res<0
                sortedCoordinates(i, :) = sortedSubset2(i2,:);
                i2 = i2 + 1;
            else % they are colinear
                %calculate longer one, discard shorter
                d1 = sqrt(sum((sortedSubset1(i1,:) - v0).^2));
                d2 = sqrt(sum((sortedSubset2(i2,:) - v0).^2));
                if d1>d2
                    sortedCoordinates(i, :) = sortedSubset1(i1,:);
                else
                    sortedCoordinates(i, :) = sortedSubset2(i2,:);
                end
                i1 = i1 + 1;
                i2 = i2 + 1;
                nDeleted = nDeleted + 1;
            end
        end
        sortedCoordinates = sortedCoordinates(1:end-nDeleted,:);
    else
        %% Break rescursion condition
        sortedCoordinates = coordinates;
    end
end