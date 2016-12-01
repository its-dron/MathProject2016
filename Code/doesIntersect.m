function [ res ] = doesIntersect( p1, p2, q1, q2, tol )
%DOESINTERSECT Checks line intersection
%   Does the line segment from p1 to p2 intersect with the line segment
%   from q1 to q2?

%% Input Handling
if nargin < 5
    tol = 0;
end
tol2 = tol.^2;

%% DebugPlot
% figure
% axis([-10 10 -10 10]);
% line([p1(1); p2(1)],[p1(2); p2(2)]);
% hold on
% line([q1(1); q2(1)],[q1(2); q2(2)]);
    
%% Set default output
res = false;

%% check if bounding boxes intercept
% (heuristic computation shortcut)
pMax = max([p1; p2], [], 1);
pMin = min([p1; p2], [], 1);
qMax = max([q1; q2], [], 1);
qMin = min([q1; q2], [], 1);

if (pMax(1) < qMin(1)) || (pMin(1) > qMax(1)) || ...
   (pMax(2) < qMin(2)) || (pMin(2) > qMax(2))
    return;
end

%% Calculate Line Equations
%Ax + By = c
pA = p2(2) - p1(2);
pB = p1(1) - p2(1);
pC = pA*p1(1) + pB*p1(2);

qA = q2(2) - q1(2);
qB = q1(1) - q2(1);
qC = qA*q1(1) + qB*q1(2);

%% Check Parallel Case
determinant = pA*qB - qA*pB;

if determinant == 0 %lines are parallel
    return;
end

%% Find Intersection
x = (qB*pC - pB*qC) / determinant;
y = (pA*qC - qA*pC) / determinant;

% plot(x,y,'d') %for debugging purposes

%% Check if the intersection exists between the points
% The following was changed because of vertical/horizontal edge conditions
% if x > min(p1(1), p2(1)) - tol && ...
%    x > min(q1(1), q2(1)) - tol && ...
%    x < max(p1(1), p2(1)) + tol && ...
%    x < max(q1(1), q2(1)) + tol && ...
%    y > min(p1(2), p2(2)) - tol && ...
%    y > min(q1(2), q2(2)) - tol && ...
%    y < max(p1(2), p2(2)) + tol && ...
%    y < max(q1(2), q2(2)) + tol
%     res = true;
% end

% first check and reject the intersection if its within a tol of endpoints
endPts = [p1;p2;q1;q2];
endPtDiff = sum(bsxfun(@minus, endPts, [x,y]).^2, 2);
if any(endPtDiff < tol2)
    return
end

% Now check the rest
pSegPoints = [p1;[x,y];p2];
pSegPointsSorted = sort(pSegPoints);
qSegPoints = [q1;[x,y];q2];
qSegPointsSorted = sort(qSegPoints);
if isequal(pSegPointsSorted(2,:), pSegPoints(2,:)) && ...
   isequal(qSegPointsSorted(2,:), pSegPoints(2,:))
    res = true;
    return
end

