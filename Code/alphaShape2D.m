function [ edges ] = alphaShape2D( x,y, alpha )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

%alpha is radius
nPoints = length(x);
epsilon = 1e-4;
edges = {};
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
        [C]=circ_cent(currentPt, secondPoint, alpha);
        
        % check if there are points in the possible circles
        distances = pdist2(C(1,:),[x,y]);
        if any(distances < alpha-epsilon)
            %theres a point in the circle
        else
            %there are no points in that circle
            %add that edge to the list
            edges{end+1} = [currentPt, secondPoint];
            continue;
        end
        
        distances = pdist2(C(2,:),[x,y]);
        if any(distances < alpha - epsilon)
            %theres a point in the circle
        else
            %there are no points in that circle
            %add that edge to the list
            edges{end+1} = [currentPt, secondPoint];
        end
    end
    
end

end

