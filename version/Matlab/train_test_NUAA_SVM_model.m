%% the script to train the SVM learner for NUAA, and then test it.
% 1. use DoG features
% 2. use LBP features
% 3. use DoG + LBP features
% only conditon 1 will be demonstrated below bacause there exits only
% slightly difference between 3 conditions.
clear all, close all, clc
addpath('./libsvm-3.19/matlab');

%% ==================================== use DoG features ====================================
%% obtain ClientTrainFeature_DoG and ImposterTrainFeature_DoG
load('DoG_NUAA_train_features.mat');

%% SVM training
MinMax = minmax([ClientTrainFeature_DoG; ImposterTrainFeature_DoG]')';

ClientTrainFeature_DoG = (ClientTrainFeature_DoG - kron(MinMax(1,:), ones(size(ClientTrainFeature_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(ClientTrainFeature_DoG, 1),1)) - kron(MinMax(1,:), ones(size(ClientTrainFeature_DoG, 1),1)));

ImposterTrainFeature_DoG = (ImposterTrainFeature_DoG - kron(MinMax(1,:), ones(size(ImposterTrainFeature_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(ImposterTrainFeature_DoG, 1),1)) - kron(MinMax(1,:), ones(size(ImposterTrainFeature_DoG, 1),1)));

Truth = [ones(size(ClientTrainFeature_DoG, 1),1);-ones(size(ImposterTrainFeature_DoG, 1),1)];

model = svmtrain(Truth, [ClientTrainFeature_DoG;ImposterTrainFeature_DoG], '-t 0');
[ClientTrainLabel, ClientTrainAccuracy, ClientTrainValue] = svmpredict(ones(size(ClientTrainFeature_DoG, 1),1), ClientTrainFeature_DoG, model);
[ImposterTrainLabel, ImposterTrainAccuracy, ImposterTrainValue] = svmpredict(-ones(size(ImposterTrainFeature_DoG, 1),1), ImposterTrainFeature_DoG, model);

save DoG_NUAA_SVM_model.mat model MinMax

%% SVM Testing
% obtain ClientTestFeature_DoG and ImposterTestFeature_DoG
load('DoG_NUAA_test_features.mat');

ClientTestFeature_DoG = (ClientTestFeature_DoG - kron(MinMax(1,:), ones(size(ClientTestFeature_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(ClientTestFeature_DoG, 1),1)) - kron(MinMax(1,:), ones(size(ClientTestFeature_DoG, 1),1)));

ImposterTestFeature_DoG = (ImposterTestFeature_DoG - kron(MinMax(1,:), ones(size(ImposterTestFeature_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(ImposterTestFeature_DoG, 1),1)) - kron(MinMax(1,:), ones(size(ImposterTestFeature_DoG, 1),1)));

% predicting
[ClientTestLabel, ClientTestAccuracy, ClientTestValue] = svmpredict(ones(size(ClientTestFeature_DoG, 1),1), ClientTestFeature_DoG, model);
[ImposterTestLabel, ImposterTestAccuracy, ImposterTestValue] = svmpredict(-ones(size(ImposterTestFeature_DoG, 1),1), ImposterTestFeature_DoG, model);
accuracy = zeros(601, 3);
for i = -3:0.01:3
    accuracy(round(i*100 + 301), :) = [mean(ClientTestValue >= i), mean(ImposterTestValue < i), ...
    (sum(ClientTestValue>=i) + sum(ImposterTestValue<i)) / (size(ClientTestFeature_DoG, 1) + size(ClientTestFeature_DoG, 1))];
end

save DoG_NUAA_SVM_model_test.mat accuracy