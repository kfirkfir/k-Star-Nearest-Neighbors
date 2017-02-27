% Main
%Code for the Kstar-NN algorithm
% paper: k*-Nearest Neighbors: From Global to Local, 
% by Oren Anava and Kfir Yehuda Levy, NIPS 2016
%http://papers.nips.cc/paper/6373-k-nearest-neighbors-from-global-to-local.pdf

%The datasest,
% -yacht
% -diabetes
% -sonar
% are not provided in this code due to license. download directly from UCI,
%%https://archive.ics.uci.edu/ml/ 
%%see also LIBSVM website,
%https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary.html
clc
clear all
close all

Data_name = 'yacht';
switch Data_name
    case 'yacht'
        load yachthydrodynamics;
    case 'diabetes'
        load diabetes;
    case 'sonar'
        load Sonar;
end


%Setting Parameters
params.k_values = [1:1:10];
params.sigma_values = [0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1, 5, 10];
params.L_C_values = [0.1 ,0.5,1,5,10,20];
validProportion = 0.5;
params.fold = 5;



E = zeros(1,3);
T = 20;%numbler of random shuffles of Data
for i=1:T
    
    %Randomly shuffling the data
    numSamples = length(Y) ;
    perm = randperm(numSamples) ;
    X = X(perm,:) ;
    Y = Y(perm,:) ;
    %Separating data into Validation and Test
    X_valid =  X( 1 : ceil( validProportion*numSamples ) , : ) ;
    X_test  = X( ceil( validProportion*numSamples ) + 1 : end , : ) ;
    Y_valid =  Y( 1 : ceil( validProportion*numSamples ) , : ) ;
    Y_test  =  Y( ceil( validProportion*numSamples ) + 1 : end , : ) ;
    
    Data.X_valid = X_valid;
    Data.Y_valid = Y_valid;
    Data.X_test = X_test;
    Data.Y_test = Y_test;
    
    %Run and compare 3 methods: K-NN, Kstar-NN, Nadaraya-Watson
    [ avg_errorKNN , avg_errorNadaraya , avg_errorKstarNN , bestRunKNN , bestRunNadaraya , bestRunKstarNN , numNeighbors , stds ] = runAll( Data, params);
    E(1) = E(1)+ avg_errorKNN;
    E(2) = E(2)+ avg_errorKstarNN;
    E(3) = E(3)+ avg_errorNadaraya;
end;
E= E/T;

disp(['Results on ',Data_name ,' dataset:'])
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(['Average Error K-NN:             ',mat2str(round(E(1),4))] )
disp(['Average Error Kstar NN:         ',mat2str(round(E(2),4))] )
disp(['Average Error Nadaraya-Watson:  ',mat2str(round(E(3),4))] )



