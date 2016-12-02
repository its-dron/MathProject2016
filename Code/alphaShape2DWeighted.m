function [ edges ] = alphaShape2D( x, y, alpha )
%ALPHASHAPE2D Compute alpha shape for set of points.

%alpha is radius
nPoints = length(x);
epsilon = 1e-4;
edges = {};

%% First compute point densities
X = [x y];
k = 5;
[~, D] = knnsearch(X, X, 'K', k + 1);   
D = D(:,2:end); % Remove reflexive neighbor
avgDistKNN = mean(D,2);
avgDist = mean(avgDistKNN);
weights = avgDistKNN / avgDist; % Ratio of distance to global average distance

for i = 1:nPoints
    currentPt = [x(i), y(i)];
    % find all points within 2 alpha of the point
    distances = pdist2(currentPt, [x,y]);
    distances = distances(:);
    
    regionalPtMask = distances < (2*alpha) & distances ~=0;
    
    for j = 1:nPoints
        if ~regionalPtMask(j)
            continue;
        end
        secondPoint = [x(j), y(j)];
        
        averageWeight = .5 * (weights(i) + weights(j));
        alphaWeighted = alpha * averageWeight;
        [C]=circ_cent(currentPt, secondPoint, alphaWeighted);
        
        if isempty(C)
            continue
        end
            
        % check if there are points in the possible circles
        distances = pdist2(C(1,:),[x,y]);
        if any(distances < alphaWeighted-epsilon)
            %theres a point in the circle
        else
            %there are no points in that circle
            %add that edge to the list
            edges{end+1} = [currentPt, secondPoint];
            continue;
        end
        
        distances = pdist2(C(2,:),[x,y]);
        if any(distances < alphaWeighted - epsilon)
            %theres a point in the circle
        else
            %there are no points in that circle
            %add that edge to the list
            edges{end+1} = [currentPt, secondPoint];
        end
    end
    
end

end

function visualizeCircles(x, y, currentPt, secondPoint, C, alpha)
    figure;
    scatter(x,y);
    hold on
    scatter(currentPt(1), currentPt(2), 'rx')
    scatter(secondPoint(1), secondPoint(2), 'kx')
    viscircles(C, [alpha; alpha]);
    axis equal;
    hold off;
end

