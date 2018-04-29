%% the script to train the SVM learner for CASIA, and then test it.
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
%% obtain TrainRealFeatures_DoG and TrainFakeFeatures_DoG
load('DoG_CASIA_train_features.mat');

%% SVM training
MinMax = minmax([TrainRealFeatures_DoG; TrainFakeFeatures_DoG]')';

TrainRealFeatures_DoG = (TrainRealFeatures_DoG - kron(MinMax(1,:), ones(size(TrainRealFeatures_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(TrainRealFeatures_DoG, 1),1)) - kron(MinMax(1,:), ones(size(TrainRealFeatures_DoG, 1),1)));

TrainFakeFeatures_DoG = (TrainFakeFeatures_DoG - kron(MinMax(1,:), ones(size(TrainFakeFeatures_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(TrainFakeFeatures_DoG, 1),1)) - kron(MinMax(1,:), ones(size(TrainFakeFeatures_DoG, 1),1)));

Truth = [ones(size(TrainRealFeatures_DoG, 1),1);-ones(size(TrainFakeFeatures_DoG, 1),1)];

model = svmtrain(Truth, [TrainRealFeatures_DoG;TrainFakeFeatures_DoG], '-t 0');
[ClientTrainLabel, ClientTrainAccuracy, ClientTrainValue] = svmpredict(ones(size(TrainRealFeatures_DoG, 1),1), TrainRealFeatures_DoG, model);
[ImposterTrainLabel, ImposterTrainAccuracy, ImposterTrainValue] = svmpredict(-ones(size(TrainFakeFeatures_DoG, 1),1), TrainFakeFeatures_DoG, model);

save DoG_CASIA_SVM_model.mat model MinMax

%% SVM Testing
% obtain TestRealFeatures_DoG and TestFakeFeatures_DoG
load('DoG_CASIA_test_features.mat');

TestRealFeatures_DoG = (TestRealFeatures_DoG - kron(MinMax(1,:), ones(size(TestRealFeatures_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(TestRealFeatures_DoG, 1),1)) - kron(MinMax(1,:), ones(size(TestRealFeatures_DoG, 1),1)));

TestFakeFeatures_DoG = (TestFakeFeatures_DoG - kron(MinMax(1,:), ones(size(TestFakeFeatures_DoG, 1),1))) ./ ...
(kron(MinMax(2,:), ones(size(TestFakeFeatures_DoG, 1),1)) - kron(MinMax(1,:), ones(size(TestFakeFeatures_DoG, 1),1)));

% predicting
[ClientTestLabel, ClientTestAccuracy, ClientTestValue] = svmpredict(ones(size(TestRealFeatures_DoG, 1),1), TestRealFeatures_DoG, model);
[ImposterTestLabel, ImposterTestAccuracy, ImposterTestValue] = svmpredict(-ones(size(TestFakeFeatures_DoG, 1),1), TestFakeFeatures_DoG, model);
accuracy = zeros(601, 3);
for i = -3:0.01:3
    accuracy(round(i*100 + 301), :) = [mean(ClientTestValue >= i), mean(ImposterTestValue < i), ...
    (sum(ClientTestValue>=i) + sum(ImposterTestValue<i)) / (size(TestRealFeatures_DoG, 1) + size(TestRealFeatures_DoG, 1))];
end

save DoG_CASIA_SVM_model_test.mat accuracy