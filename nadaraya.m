function [ avg_error , errors ] = nadaraya( X_train , X_test , Y_train , Y_test , sigma )
%Nadaraya-Watson Algorithm

numSamples = length( Y_test ) ;
D = distanceMatrix( X_test , X_train ) ;
D = D / max(max(D)) ;
errors = zeros(numSamples,1) ;

for i = 1:numSamples
    
    alpha = (1/sigma) * exp( - (1/sigma^2) * D(i,:).^2 ) ;
    alpha = alpha ./ sum( alpha ) ;
    
    est_Y = alpha * Y_train ;
    errors(i) = abs( est_Y - Y_test(i) ) ; 

end

avg_error = mean( errors ) ;

end

