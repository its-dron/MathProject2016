function [ normals ] = estimateNormals( X, k )
%ESTIMATENORMALS Estimate surface normal at each point in X.
%
% X - N x 3 data matrix
% k - number of neighbors to use in estimation

    nPoints = size(X, 1);
    
    % Do KNN
    [Idx, D] = knnsearch(X, X, 'K', k + 1);    
    
    normals = zeros(nPoints, 3);
    for i = 1:nPoints
        pts = X(Idx(i,:),:);
        pts = bsxfun(@minus, pts, mean(pts));
        
        dist = D(i,:);
        
        mu = mean(dist(:));
        xi = exp(-(dist / mu).^2);
        ptsWeighted = bsxfun(@times, pts, xi');
        
        C = cov(ptsWeighted);
        [v, ~] = eig(C);
        normals(i,:) = v(:,1)';
    end
end

