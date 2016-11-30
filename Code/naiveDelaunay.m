function [ triangles ] = naiveDelaunay( x,y )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

nPoints = length(x);

triangles = {};
for i = 1:nPoints - 2
    p1 = [x(i),y(i)];
    for j = i+1:nPoints-1
        p2 = [x(j), y(j)];
        dist12 = sqrt((p2(1)-p1(1))^2 + (p2(2)-p1(2))^2);
        for k=j+1:nPoints
            p3 = [x(k), y(k)];
            dist13 = sqrt((p3(1)-p1(1))^2 + (p3(2)-p1(2))^2);
            dist23 = sqrt((p2(1)-p3(1))^2 + (p2(2)-p3(2))^2);
            
            %get circle center
            [ center, radius ] = circle3pt( p1, p2, p3 );
            
            centerX = center(1);
            centerY = center(2);
            
            dists = sqrt((centerX-x).^2 + (centerY-y).^2);
            nInCircle = sum(dists <= radius);
            
            if nInCircle > 3
                %this is not a delaunay triangle
                continue;
            else
                %this is a delaunay triangle
                triangles{end+1}=[p1;p2;p3];
            end
        end
    end
end

end

