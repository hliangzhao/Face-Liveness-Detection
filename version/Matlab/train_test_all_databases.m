%% the script to train the SVM learner for all 3 databases, and then test it.
% 1. use DoG features
% 2. use LBP features
% 3. use HSV features
% 4. use DoG + LBP features
% 5. use DoG + HSV features
% 6. use LBP + HSV features
% 7. use DoG + LBP + HSV features
% only conditon 1 will be demonstrated below bacause there exits only
% slightly difference between 7 conditions.
clear all, close all, clc
addpath('./libsvm-3.19/matlab');

%% ==================================== use DoG features ====================================
TrainRealFeaturesAll_DoG = [];
TrainFakeFeaturesAll_DoG = [];
%% obtain TrainRealFeaturesAll_DoG and TrainFakeFeaturesAll_DoG of 3 databases
load('DoG_NUAA_train_features.mat');
TrainRealFeaturesAll_DoG = [TrainRealFeaturesAll_DoG; ClientTrainFeature_DoG];
TrainFakeFeaturesAll_DoG = [TrainFakeFeaturesAll_DoG; ImposterTrainFeature_DoG];

load('DoG_CASIA_train_features.mat');
TrainRealFeaturesAll_DoG = [TrainRealFeaturesAll_DoG; TrainRealFeatures_DoG];
TrainFakeFeaturesAll_DoG = [TrainFakeFeaturesAll_DoG; TrainFakelFeatures_DoG];

load('DoG_REPLAY_ATTACK_train_features.mat');
TrainRealFeaturesAll_DoG = [TrainRealFeaturesAll_DoG; TrainRealFeatures_DoG];
TrainFakeFeaturesAll_DoG = [TrainFakeFeaturesAll_DoG; TrainFakelFeatures_DoG];

%% SVM training
MinMax = minmax([TrainRealFeaturesAll_DoG; TrainFakeFeaturesAll_DoG]')';

TrainRealFeaturesAll_DoG = (TrainRealFeaturesAll_DoG - kron(MinMax(1,:), ones(size(TrainRealFeaturesAll_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(TrainRealFeaturesAll_DoG, 1),1)) - kron(MinMax(1,:), ones(size(TrainRealFeaturesAll_DoG, 1),1)));

TrainFakeFeaturesAll_DoG = (TrainFakeFeaturesAll_DoG - kron(MinMax(1,:), ones(size(TrainFakeFeaturesAll_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(TrainFakeFeaturesAll_DoG, 1),1)) - kron(MinMax(1,:), ones(size(TrainFakeFeaturesAll_DoG, 1),1)));

Truth = [ones(size(TrainRealFeaturesAll_DoG, 1),1);-ones(size(TrainFakeFeaturesAll_DoG, 1),1)];

model = svmtrain(Truth, [TrainRealFeaturesAll_DoG;TrainFakeFeaturesAll_DoG], '-t 0');
[ClientTrainLabel, ClientTrainAccuracy, ClientTrainValue] = svmpredict(ones(size(TrainRealFeaturesAll_DoG, 1),1), TrainRealFeaturesAll_DoG, model);
[ImposterTrainLabel, ImposterTrainAccuracy, ImposterTrainValue] = svmpredict(-ones(size(TrainFakeFeaturesAll_DoG, 1),1), TrainFakeFeaturesAll_DoG, model);

save DoG_all_databases_SVM_model.mat model MinMax

%% SVM Testing
% obtain TestRealFeatures_DoG and TestFakeFeatures_DoG
TestRealFeaturesAll_DoG = [];
TestFakeFeaturesAll_DoG = [];
%% obtain TestRealFeaturesAll_DoG and TestFakeFeaturesAll_DoG of 3 databases
load('DoG_NUAA_train_features.mat');
TestRealFeaturesAll_DoG = [TestRealFeaturesAll_DoG; ClientTrainFeature_DoG];
TestFakeFeaturesAll_DoG = [TestFakeFeaturesAll_DoG; ImposterTrainFeature_DoG];

load('DoG_CASIA_train_features.mat');
TestRealFeaturesAll_DoG = [TestRealFeaturesAll_DoG; TestRealFeatures_DoG];
TestFakeFeaturesAll_DoG = [TestFakeFeaturesAll_DoG; TrainFakelFeatures_DoG];

load('DoG_REPLAY_ATTACK_train_features.mat');
TestRealFeaturesAll_DoG = [TestRealFeaturesAll_DoG; TestRealFeatures_DoG];
TestFakeFeaturesAll_DoG = [TestFakeFeaturesAll_DoG; TrainFakelFeatures_DoG];

%% SVM training
MinMax = minmax([TestRealFeaturesAll_DoG; TestFakeFeaturesAll_DoG]')';

TestRealFeaturesAll_DoG = (TestRealFeaturesAll_DoG - kron(MinMax(1,:), ones(size(TestRealFeaturesAll_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(TestRealFeaturesAll_DoG, 1),1)) - kron(MinMax(1,:), ones(size(TestRealFeaturesAll_DoG, 1),1)));

TestFakeFeaturesAll_DoG = (TestFakeFeaturesAll_DoG - kron(MinMax(1,:), ones(size(TestFakeFeaturesAll_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(TestFakeFeaturesAll_DoG, 1),1)) - kron(MinMax(1,:), ones(size(TestFakeFeaturesAll_DoG, 1),1)));

% predicting
[ClientTestLabel, ClientTestAccuracy, ClientTestValue] = svmpredict(ones(size(TestRealFeaturesAll_DoG, 1),1), TestRealFeaturesAll_DoG, model);
[ImposterTestLabel, ImposterTestAccuracy, ImposterTestValue] = svmpredict(-ones(size(TestFakeFeaturesAll_DoG, 1),1), TestFakeFeaturesAll_DoG, model);
accuracy = zeros(601, 3);
for i = -3:0.01:3
    accuracy(round(i*100 + 301), :) = [mean(ClientTestValue >= i), mean(ImposterTestValue < i), ...
    (sum(ClientTestValue>=i) + sum(ImposterTestValue<i)) / (size(TestRealFeaturesAll_DoG, 1) + size(TestFakeFeaturesAll_DoG, 1))];
end

save DoG_all_databases_SVM_model_test.mat accuracy
