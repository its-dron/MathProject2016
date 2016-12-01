function [ C ] = sphere_cent( p1, p2, p3, R )
%SPHERE_CENT Find 2 valid centers of a sphere of radius R containing p1 p2
% and p3
%
% From http://stackoverflow.com/questions/11719168/how-do-i-find-the-sphere-center-from-3-points-and-radius
p12 = p2 - p1;
p13 = p3 - p1;
R_squared = R*R;

% surface normal
n = cross(p12, p13);
nn = dot(n,n);

if nn < 10*eps
    % points are collinear
    C = [];
    return;
end

% p0 is center of circumcircle
p0 = cross(dot(p12,p12)*p13 - dot(p13,p13)*p12, n) / (2*nn) + p1;

p10 = p0 - p1;
p10_mag_squared = dot(p10,p10);

if p10_mag_squared > R_squared
    % radius of circumcircle > alpha
    C = [];
    return;
end

t = sqrt( (R^2 - dot(p10,p10)) / nn );

C = [p0 + t*n; p0 - t*n];
end

