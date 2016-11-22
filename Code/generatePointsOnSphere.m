function [ X, Y, Z ] = generatePointsOnSphere( numPoints, radius )
%GENERATEPOINTSONSPHERE Generate points uniformly distributed over the
%surface of a sphere with given radius.
%
% If 3 outputs requested, will return X, Y, and Z as seperate column vectors,
% otherwise returns an N x 3 data matrix.
    if ~exist('radius', 'var')
        radius = 1;
    end

    % Uniformly sample in [-1, 1] and [0, 2*pi)
    u = 2*rand(numPoints, 1) - 1;
    th = 2*pi*rand(numPoints, 1);
    
    X = radius*sqrt(1 - u.^2) .* cos(th);
    Y = radius*sqrt(1 - u.^2) .* sin(th);
    Z = radius*u;
    
    if nargout ~= 3
        X = [X, Y, Z];
    end
end
