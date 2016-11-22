function [ cleaned ] = removeOutliers( X, k, outlierPct )
%REMOVEOUTLIERS Remove outliers based on average distance
    
    nPoints = size(X, 1);
    
    % Do KNN
    [~, D] = knnsearch(X, X, 'K', k + 1);  
    
    % Remove self from list of nearest neighbors
    D = D(:,2:end);
    
    % Find average squared distance
    avgDist = mean(D.^2, 2);
    
    % Append index and sort
    sorted = sortrows([avgDist, (1:nPoints)']);
    
    % TODO: Look into heuristics to automatically pick outlierPct
    % Remove top pct
    numToRemove = round(outlierPct * nPoints / 100);
    toKeep = sorted(1:end-numToRemove, 2);
    
    % 
    cleaned = X(toKeep, :);
end

