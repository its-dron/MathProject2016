function [ tri ] = alphaShape3D( x, y, z, alpha, plotFlag )
%ALPHASHAPEeD (Very naively) compute alpha shape for set of points.

if nargin < 5
    plotFlag = false;
end

%alpha is radius
nPoints = length(x);
epsilon = 1e-4;
tri = [];
sphereOpacity = 0.25;

if plotFlag
    %ss stands for sphere surface
    figure;
    scatter3(x,y,z);
    hold on
    
    [ssX, ssY, ssZ] = sphere;
    ssX = (ssX/2) * alpha;
    ssY = (ssY/2) * alpha;
    ssZ = (ssZ/2) * alpha;
end


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
            
            [C] = sphere_cent(currentPt, secondPoint, thirdPoint, alpha);
        
            if isempty(C)
                continue
            end
            
            % check if there are points in the possible circles
            distances = pdist2(C(1,:), [x y z]);
            if any(distances < alpha-epsilon)
                %theres a point in the circle
            else
                %there are no points in that circle
                %add that edge to the list
                tri(end+1,:) = [i j k];
                
                if plotFlag
                    h = surf(ssX + x(i), ssY + y(j), ssZ + z(j));
                    set(h, 'FaceAlpha', sphereOpacity)
                    shading interp
                end
                
                continue;
            end

            distances = pdist2(C(2,:),[x y z]);
            if any(distances < alpha - epsilon)
                %theres a point in the circle
            else
                %there are no points in that circle
                %add that edge to the list
                tri(end+1,:) = [i j k];

                if plotFlag
                    h = surf(ssX + x(i), ssY + y(j), ssZ + z(j));
                    set(h, 'FaceAlpha', sphereOpacity)
                    shading interp
                end
            end
        end

    end
    
end

end

