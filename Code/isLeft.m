function [ result ] = isLeft( p1, p2, p3 )
%isLeft is p1s left of line from p2 to p3?
%p1 is a nx2 vector of points; n can be as small as 1.
%   Returns:
%       positive if p1 is left of line from p2 to p3
%       0 if p1 is on  line from p2 to p3
%       negative if p1 is right of line from p2 to p3

result = (p1(:,2)-p2(2))*(p3(1)-p2(1)) - (p1(:,1)-p2(1))*(p3(2)-p2(2));

end

