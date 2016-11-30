function [ center, radius ] = circle3pt( p1, p2, p3 )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    x1 = p1(1);
    y1 = p1(2);
    x2 = p2(1);
    y2 = p2(2);
    x3 = p3(1);
    y3 = p3(2);
    
    ma = (y2 - y1) / (x2 - x1);
    mb = (y3-y2) / (x3-x2);
    
    centerX = (ma*mb*(y1-y3) + mb*(x1 + x2) - ma*(x2+x3)) / ...
                (2*(mb-ma));
    centerY = -(1/mb)*(centerX-((x2+x3)/2))+((y2+y3)/2);
    
    center = [centerX, centerY];
    
    radius = max([sqrt((centerX-x1)^2 + (centerY-y1)^2), ...
                 sqrt((centerX-x2)^2 + (centerY-y2)^2), ...
                 sqrt((centerX-x3)^2 + (centerY-y3)^2)]);
end

