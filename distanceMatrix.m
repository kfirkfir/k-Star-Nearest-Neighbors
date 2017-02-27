function [ D ] = distanceMatrix( X_test , X_train )
%DISTANCEMATRIX Summary of this function goes here
%   Detailed explanation goes here

numSamples = size(X_test,1) ;
potentialNeighbors = size(X_train,1) ;
D = zeros(numSamples,potentialNeighbors) ;

for i = 1:numSamples

    for j = 1:potentialNeighbors
        
        D(i,j) = sqrt( sum( ( X_test(i,:) - X_train(j,:) ).^2 ) ) ;
        
    end
    
end



end

