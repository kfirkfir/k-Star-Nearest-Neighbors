function [ avgErrorKNN , avg_errorNadaraya , avg_errorKstarNN , bestRunKNN , bestRunNadaraya , bestRunKstarNN , numNeighbors , stds  ] = runAll(Data , params )
%Cross validate and Test 3 methods: K-NN, Kstar-NN, Nadaraya-Watson

stds = zeros(3,1);
k_values = params.k_values;
sigma_values = params.sigma_values; 
L_C_values = params.L_C_values;
fold = params.fold;


X_valid = Data.X_valid;
X_test = Data.X_test;

Y_valid = Data.Y_valid;
Y_test = Data.Y_test;


[ ~ , bestRunKNN ] = crossValidationKNN( X_valid , Y_valid , k_values , fold ) ;
[ avgErrorKNN , errorsKNN ] = knn( X_valid , X_test , Y_valid , Y_test , bestRunKNN ) ;

[ ~ , bestRunNadaraya ] = crossValidationNadaraya( X_valid , Y_valid , sigma_values , fold ) ;
[ avg_errorNadaraya , errorsNadaraya ] = nadaraya( X_valid , X_test , Y_valid , Y_test , sigma_values(bestRunNadaraya) ) ;

[ ~ , bestRunKstarNN ] = crossValidationKstarNN( X_valid , Y_valid , L_C_values , fold ) ;
[ avg_errorKstarNN , errorsKstarNN , numNeighbors ] = kStarNN( X_valid , X_test , Y_valid , Y_test , L_C_values(bestRunKstarNN) ) ;

stds(1,1) = std( errorsKNN ) ;
stds(2,1) = std( errorsNadaraya ) ;
stds(3,1) = std( errorsKstarNN ) ;



end

