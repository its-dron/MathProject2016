function [ X, Y, Z ] = generatePointsOnSphere( numPoints, radius )
%GENERATEPOINTSONSPHERE Generate points uniformly distributed over the
%surface of a sphere with given radius.

    if ~exist('radius', 'var')
        radius = 1;
    end

    u = 2*rand(numPoints, 1) - 1;
    th = 2*pi*rand(numPoints, 1);
    
    X = radius*sqrt(1 - u.^2) .* cos(th);
    Y = radius*sqrt(1 - u.^2) .* sin(th);
    Z = radius*u;
end
