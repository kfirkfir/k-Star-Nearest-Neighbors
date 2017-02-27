function [ avg_error , errors , numNeighbors ] = kStarNN( X_train , X_test , Y_train , Y_test , L_C )
%kStar-NN Algorithm

numSamples = length( Y_test ) ;
potentialNeighbors = size( X_train , 1 ) ;

D = distanceMatrix( X_test , X_train ) ;
errors = zeros(numSamples,1) ;
numNeighbors = zeros(numSamples,1) ;
alpha = zeros(numSamples,potentialNeighbors) ;

for i =1:numSamples 
    
    [~,sortIndex] = sort( D(i,:) , 'ascend' ) ;
    beta = [ L_C * D(i,sortIndex)   10^6 ] ;
    lambda = beta(1)+1 ;
    k = 0 ;
    Sum_beta = 0;
    Sum_beta_square = 0;
    while ( lambda>beta(k+1) )&&(k<length(beta)-1)
        
        k = k+1;
        Sum_beta = Sum_beta + beta(k);
        Sum_beta_square = Sum_beta_square + (beta(k))^2;
        lambda = (1/k) * ( Sum_beta + sqrt( k  + Sum_beta^2 - k * Sum_beta_square ) ) ; 
   
    end
    
    
    numNeighbors(i) = k  ;
    
    alpha(i,:) = max( lambda - L_C * D(i,:) , 0 ) ;
    alpha(i,:) = alpha(i,:) ./ sum( alpha(i,:) ) ;
    
    est_Y = alpha(i,:) * Y_train ;
    errors(i) = abs( est_Y - Y_test(i) ) ; 

end

avg_error = mean( errors ) ;

end

