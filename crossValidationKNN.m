function [ errors , bestRun ] = crossValidationKNN( X , Y , k_values , fold )

numRuns = length( k_values ) ;
errors = zeros(numRuns,fold) ;
numSamples = length(Y) ;


min = 10^6 ;

for k = 1:numRuns
    
    for j = 1:fold
        
        X_train = X ;
        X_train(ceil(numSamples*((j-1)/fold))+1:ceil(numSamples*(j/fold)),:) = [] ;
        X_test = X(ceil(numSamples*((j-1)/fold))+1:ceil(numSamples*(j/fold)),:) ;
        
        Y_train = Y ;
        Y_train(ceil(numSamples*((j-1)/fold))+1:ceil(numSamples*(j/fold))) = [] ;
        Y_test = Y(ceil(numSamples*((j-1)/fold))+1:ceil(numSamples*(j/fold))) ;
        
        [ errors(k,j) , ~ ] = knn( X_train , X_test , Y_train , Y_test , k_values(k) ) ;
        
    end
    
    if ( mean(errors(k,:)) < min )
        min = mean(errors(k,:)) ;
        bestRun = k ;
    end
end


end

