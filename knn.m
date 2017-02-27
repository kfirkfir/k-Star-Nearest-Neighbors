function [ avg_error , errors ] = knn( X_train , X_test , Y_train , Y_test , k )
%k-NN Algorithm

numSamples = length( Y_test ) ;
D = distanceMatrix( X_test , X_train ) ;
errors = zeros(numSamples,1) ;

for i = 1:numSamples
    
    [~,sortIndex] = sort( D(i,:) , 'ascend' ) ;
    Dsorted = D(i,sortIndex) ;
    distMax_k = Dsorted(k) ;
    
    alpha = (1/k) * ( distMax_k - D(i,:) >= 0 ) ;
    
    est_Y = alpha * Y_train ;
    errors(i) = abs( est_Y - Y_test(i) ) ; 

end

avg_error = mean( errors ) ;

end

