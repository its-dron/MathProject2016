function [ tri ] = alphaShape3DWeighted( x, y, z, alpha )
%ALPHASHAPE3DNAIVEWEIGHTED (Very naively) compute alpha shape for set of points.

%alpha is radius
nPoints = length(x);
epsilon = 1e-4;
tri = [];

%% First compute point densities
X = [x y z];
k = 5;
[~, D] = knnsearch(X, X, 'K', k + 1);   
D = D(:,2:end); % Remove reflexive neighbor
avgDistKNN = mean(D,2);
avgDist = mean(avgDistKNN);
weights = avgDistKNN / avgDist; % Ratio of distance to global average distance

%% Okay now run alpha shapes, but adjust alpha by calculated density
for i = 1:nPoints
    currentPt = [x(i) y(i) z(i)];
    % find all points within 2 alpha of the point
    distances = pdist2(currentPt, [x y z]);
    distances = distances(:);
    
    % The transpose here is so we can do "for j = regionalPtIdx" below
    regionalPtIdx = find(distances < (2*alpha) & distances ~=0)';
    if isempty(regionalPtIdx)
        continue
    end
    
    for j = regionalPtIdx
        secondPoint = [x(j) y(j) z(j)];
        
        for k = regionalPtIdx
            if k == j
                continue;
            end
            thirdPoint = [x(k) y(k) z(k)];
            
            averageWeight = 1/3 * (weights(i) + weights(j) + weights(k));
            alphaWeighted = alpha * averageWeight;
            [C] = sphere_cent(currentPt, secondPoint, thirdPoint, alphaWeighted);
        
            if isempty(C)
                continue
            end
            
            % check if there are points in the possible circles
            distances = pdist2(C(1,:), [x y z]);
            if any(distances < alphaWeighted - epsilon)
                %theres a point in the circle
            else
                %there are no points in that circle
                %add that edge to the list
                tri(end+1,:) = [i j k];
                continue;
            end

            distances = pdist2(C(2,:),[x y z]);
            if any(distances < alphaWeighted - epsilon)
                %theres a point in the circle
            else
                %there are no points in that circle
                %add that edge to the list
                tri(end+1,:) = [i j k];
            end
        end

    end
    
end

end

